import 'dart:async';

import 'package:lol_kek/src/blocks/bloc.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends Bloc {
  final _track = StreamController<Track>();

  get track => _track.stream;

  DetailsBloc(Track track) {
    _track.add(track);
  }

  @override
  void dispose() {
    _track.close();
  }
}
