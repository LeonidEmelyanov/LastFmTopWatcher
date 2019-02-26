import 'dart:async';

import 'package:lol_kek/src/blocks/bloc.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends Bloc {
  final _trackController = StreamController<Track>();
  final Track initialData;

  get trackStream => _trackController.stream;

  DetailsBloc(this.initialData);

  @override
  void dispose() {
    _trackController.close();
  }
}
