import 'package:flutter/material.dart';
import 'package:lol_kek/loader.dart';
import 'package:lol_kek/track.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('LastFM Top Songs'),
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

  RefreshWidget(
      {@required this.tracks,
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
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) => SongTile(
              track: tracks[index],
              onTap: () => Navigator.pushNamed(context, '/details'),
            ),
      );
}

class SongTile extends ListTile {
  SongTile({@required Track track, GestureTapCallback onTap})
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
            onTap: () => onTap);
}
