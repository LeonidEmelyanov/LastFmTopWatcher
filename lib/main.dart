import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Loader _loader = Loader();
  final _tracks = List<Track>();

  @override
  void initState() {
    super.initState();
    _loader.getTopTracks().then((tracks) {
      setState(() {
        _tracks.clear();
        _tracks.addAll(tracks);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _tracks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tracks[index].name),
            subtitle: Text(_tracks[index].artist),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(_tracks[index].imgUrl),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Loader {
  final _key = 'd64be117563ee910b260f172319b3001';

  Future<List<Track>> getTopTracks() async {
    final url =
        "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=$_key&format=json";
    final tracks = List<Track>();
    final responce = await http.get(url);

    json.decode(responce.body)['tracks']['track'].forEach((track) {
      tracks.add(Track(
          name: track['name'],
          artist: track['artist']['name'],
          imgUrl: track['image'][3]['#text']));
    });
    return tracks;
  }
}

class Track {
  final String name;
  final String artist;
  final String imgUrl;

  Track({this.name, this.artist, this.imgUrl});

  @override
  String toString() {
    return "$name by ($artist)\n";
  }
}
