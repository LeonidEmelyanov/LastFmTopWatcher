import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends Bloc {
  final _trackController = StreamController<Track>();
  final Track initialData;

  get trackStream => _trackController.stream;

  DetailsBloc(this.initialData);

  @override
  void dispose() async {
    await _trackController.close();
  }
}
