import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_kek/track.dart';

class Loader {
  final _key = 'd64be117563ee910b260f172319b3001';
  final _baseUrl = "http://ws.audioscrobbler.com/2.0/";

  Future<List<Track>> getChart() async {
    final url = "$_baseUrl?${_getParams({'method': 'chart.gettoptracks'})}";
    final tracks = List<Track>();
    final response = await http.get(url);

    json.decode(response.body)['tracks']['track'].forEach((track) {
      tracks.add(Track.fromJson(track));
    });
    return tracks;
  }

  Future<Track> getTrackInfo(String trackName, String artistName) async {
    final url = "$_baseUrl?${_getParams({
      'method': 'track.getInfo',
      'artist': '$artistName',
      'track': '$trackName'
    })}";
    final response = await http.get(url);
    final track = json.decode(response.body)['track'];
    return Track.fromJson(track);
  }

  String _getParams(final Map<String, String> params) {
    params.putIfAbsent("api_key", () => _key);
    params.putIfAbsent("format", () => "json");

    return params.entries.map((f) => "${f.key}=${f.value}").join('&');
  }
}
