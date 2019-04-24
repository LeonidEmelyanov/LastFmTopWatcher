import 'dart:async';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/resources/loader.dart';

class ChartBloc {
  final _loader = Loader();
  final _tracksController = StreamController<List<Track>>();

  get tracksStream => _tracksController.stream;

  Future<dynamic> loadChart() async {
    _tracksController.add([]);
    try {
      _tracksController.add(await _loader.getChart());
    } catch (e) {
      _tracksController.addError(e);
    }
  }

  void dispose() async {
    await _tracksController.close();
  }
}