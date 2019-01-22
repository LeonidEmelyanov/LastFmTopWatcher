import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_kek/src/models/track.dart';

class Loader {
  static final Loader _loader = Loader._internal();

  final _key = 'd64be117563ee910b260f172319b3001';
  final _baseUrl = "http://ws.audioscrobbler.com/2.0/";

  factory Loader() => _loader;

  Future<List<Track>> getChart() async {
    final url = "$_baseUrl?${_getParams({
      'method': 'chart.gettoptracks',
    })}";

    final response = await http.get(url);
    return json
        .decode(response.body)['tracks']['track']
        .map<Track>((track) => Track.fromJson(track))
        .toList();
  }

  Future<Track> getTrackInfo(String trackName, String artistName) async {
    final url = "$_baseUrl?${_getParams({
      'method': 'track.getInfo',
      'artist': '$artistName',
      'track': '$trackName',
    })}";
    final response = await http.get(url);

    return Track.fromJson(json.decode(response.body)['track']);
  }

  String _getParams(final Map<String, String> params) {
    params.putIfAbsent("api_key", () => _key);
    params.putIfAbsent("format", () => "json");

    return params.entries.map((f) => "${f.key}=${f.value}").join('&');
  }

  Loader._internal();
}
