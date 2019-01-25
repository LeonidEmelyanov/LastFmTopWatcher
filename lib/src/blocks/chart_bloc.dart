import 'dart:async';

import 'package:lol_kek/src/blocks/bloc_provider.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/resources/loader.dart';

class ChartBloc extends BaseBlock {
  final _loader = Loader();
  final _dataController = StreamController<List<Track>>();

  get chartData => _dataController.stream;

  Future<void> loadChart() async {
    _dataController.add([]);

    try {
      final trakcs = await _loader.getChart();
      _dataController.add(trakcs);
    } on Exception catch (e) {
      _dataController.addError(e);
    }
  }

  @override
  void dispose() {
    _dataController.close();
  }
}
