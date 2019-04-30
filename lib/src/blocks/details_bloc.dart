import 'dart:async';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc {
  final _trackController = StreamController<Track>();

  get trackStream => _trackController.stream;

  set track(Track track) => _trackController.add(track);

  void dispose() async {
    await _trackController.close();
  }
}
