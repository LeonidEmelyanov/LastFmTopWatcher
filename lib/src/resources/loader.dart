import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lol_kek/src/models/track.dart';

class Loader {
  static final Loader _loader = Loader._internal();
  static final _key = 'd64be117563ee910b260f172319b3001';

  final Dio _dio = Dio(BaseOptions()
    ..baseUrl = "http://ws.audioscrobbler.com/2.0"
    ..responseType = ResponseType.plain)
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (options) => options.queryParameters.addAll({
              "api_key": _key,
              "format": "json",
            })));

  factory Loader() => _loader;

  Future<List<Track>> getChart() async {
    final response =
        await _dio.get('/', queryParameters: {'method': 'chart.gettoptracks'});

    return json
        .decode(response.data)['tracks']['track']
        .map<Track>((track) => Track.fromJson(track))
        .toList();
  }

  Future<Track> getTrackInfo(String trackName, String artistName) async {
    final response = await _dio.get('/', queryParameters: {
      'method': 'track.getInfo',
      'artist': '$artistName',
      'track': '$trackName',
    },);

    return Track.fromJson(json.decode(response.data)['track']);
  }

  Loader._internal();
}
