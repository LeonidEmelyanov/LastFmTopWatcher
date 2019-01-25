import 'dart:async';

import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/resources/loader.dart';
import 'package:scoped_model/scoped_model.dart';

class ChartModel extends Model {
  final _loader = Loader();
  final _tracks = List<Track>();

  get tracks => _tracks;

  Future<void> loadChart() async {
    _tracks.clear();
    notifyListeners();

    _tracks.addAll(await _loader.getChart());
    notifyListeners();
  }
}
