import 'dart:async';

import 'package:lol_kek/src/blocks/bloc.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/resources/loader.dart';

class ChartBloc extends Bloc {
  final _loader = Loader();
  final _tracks = StreamController<List<Track>>();

  get tracks => _tracks.stream;

  Future<dynamic> loadChart() async {
    _tracks.add([]);
    try {
      _tracks.add(await _loader.getChart());
    } catch (e) {
      _tracks.addError(e);
    }
  }

  @override
  void dispose() {
    _tracks.close();
  }
}
