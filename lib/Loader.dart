import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_kek/Track.dart';

class Loader {
  final _key = 'd64be117563ee910b260f172319b3001';

  Future<List<Track>> getTopTracks() async {
    final url =
        "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=$_key&format=json";
    final tracks = List<Track>();
    final response = await http.get(url);

    json.decode(response.body)['tracks']['track'].forEach((track) {
      tracks.add(Track(
          name: track['name'],
          artist: track['artist']['name'],
          imgUrl: track['image'][3]['#text']));
    });
    return tracks;
  }
}
