import 'package:flutter/widgets.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsBloc extends ChangeNotifier {
  Track _track;

  DetailsBloc(this._track);

  get track => _track;
}
