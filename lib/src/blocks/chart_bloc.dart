import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/resources/loader.dart';

class ChartBloc extends ChangeNotifier {
  final _loader = Loader();
  var _tracks = <Track>[];
  dynamic _error;

  get tracks => _tracks;
  get error => _error;

  Future<dynamic> loadChart() async {
    _tracks.clear();
    _error = null;
    notifyListeners();

    return await _loader
        .getChart()
        .then((tracks) => _tracks.addAll(tracks))
        .catchError((error) => _error = error)
        .whenComplete(() => notifyListeners());
  }
}
