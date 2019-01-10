import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lol_kek/track.dart';

class Loader {
  static final Loader _loader = Loader._internal();

  final _key = 'd64be117563ee910b260f172319b3001';
  final _baseUrl = "http://ws.audioscrobbler.com/2.0/";

  final chart = StreamController<List<Track>>();
  final details = StreamController<Track>();

  factory Loader() => _loader;

  Future<void> getChart() async {
    final url = "$_baseUrl?${_getParams({
      'method': 'chart.gettoptracks',
    })}";

    try {
      final response = await http.get(url);

      chart.add(json
          .decode(response.body)['tracks']['track']
          .map<Track>((track) => Track.fromJson(track))
          .toList());
    } on Exception catch (e) {
      chart.addError(e);
    }
  }

  Future<void> getTrackInfo(String trackName, String artistName) async {
    final url = "$_baseUrl?${_getParams({
      'method': 'track.getInfo',
      'artist': '$artistName',
      'track': '$trackName',
    })}";
    final response = await http.get(url);

    details.add(Track.fromJson(json.decode(response.body)['track']));
  }

  String _getParams(final Map<String, String> params) {
    params.putIfAbsent("api_key", () => _key);
    params.putIfAbsent("format", () => "json");

    return params.entries.map((f) => "${f.key}=${f.value}").join('&');
  }

  Loader._internal();
}
