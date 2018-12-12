import 'package:flutter/material.dart';
import 'package:lol_kek/Loader.dart';
import 'package:lol_kek/Track.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LastFM Top Chart'),
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
  final _loader = Loader();
  final _tracks = List<Track>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _load();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Future<void> _load() {
    setState(() {
      _tracks.clear();
      _opacity = 0.0;
    });

    return _loader.getTopTracks().then((tracks) {
      setState(() {
        _tracks.addAll(tracks);
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: RefreshWidget(
          tracks: _tracks,
          opacity: _opacity,
          refreshCallback: () => _load(),
        ),
      );
}

class RefreshWidget extends RefreshIndicator {
  final List<Track> tracks;
  final double opacity;
  final RefreshCallback refreshCallback;

  RefreshWidget({@required this.tracks,
    @required this.opacity,
    @required this.refreshCallback})
      : super(
    child: AnimatedOpacity(
      child: SongsWidget(
        tracks: tracks,
      ),
      opacity: opacity,
      duration: Duration(milliseconds: 300),
    ),
    onRefresh: refreshCallback,
  );
}

class SongsWidget extends StatelessWidget {
  final tracks;

  SongsWidget({@required this.tracks}) : super();

  @override
  Widget build(BuildContext context) =>
      ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) => SongTile(track: tracks[index]),
      );
}

class SongTile extends ListTile {
  SongTile({@required Track track})
      : super(
      title: Text(track.name),
      subtitle: Text(track.artist),
      leading: ClipOval(
        child: Container(
          width: 48,
          height: 48,
          child: Image.network(track.imgUrl),
        ),
      ),
      onTap: () => {});
}
