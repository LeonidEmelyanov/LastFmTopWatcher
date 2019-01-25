import 'package:lol_kek/src/models/track.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsModel extends Model {
  Track _track;

  get track => _track;

  DetailsModel(this._track) {
    notifyListeners();
  }
}
