import 'package:flutter/widgets.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends ChangeNotifier {
  Track _track;

  get track => _track;
  set track(Track track) {
    _track = track;
    notifyListeners();
  }
}
