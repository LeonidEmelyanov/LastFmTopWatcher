import 'dart:async';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc {
  final _trackController = StreamController<Track>();
  final Track initialData;

  get trackStream => _trackController.stream;

  DetailsBloc(this.initialData);

  void dispose() async {
    await _trackController.close();
  }
}
