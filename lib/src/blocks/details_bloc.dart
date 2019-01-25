import 'dart:async';

import 'package:lol_kek/src/blocks/bloc_provider.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends BaseBlock {
  final _dataController = StreamController<Track>();

  get trackInfo => _dataController.stream;

  DetailsBloc(Track _track) {
    _dataController.add(_track);
  }

  @override
  void dispose() {
    _dataController.close();
  }
}
