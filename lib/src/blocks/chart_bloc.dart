import 'dart:async';

import 'package:lol_kek/src/blocks/block_provider.dart';
import 'package:lol_kek/src/resources/loader.dart';

class ChartBloc extends BaseBlock {
  final _loader = Loader();
  final _dataController = StreamController();
  final _actionController = StreamController();

  get chartData => _dataController.stream;
  get trackClick => _actionController.sink;

  ChartBloc() {
    _actionController.stream.listen((data) {});
  }

  void loadChart() async {
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
    _actionController.close();
  }
}
