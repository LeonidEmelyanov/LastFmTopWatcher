import 'package:flutter/material.dart';
import 'package:lol_kek/loader.dart';
import 'package:lol_kek/details_page.dart';
import 'package:lol_kek/track.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _loader = Loader();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loader.getChart();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('LastFM Top Songs'),
        ),
        body: StreamBuilder(
          stream: _loader.chart.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
            if (!snapshot.hasData) {
              _refreshIndicatorKey.currentState?.show();
            }

            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: snapshot.hasData
                  ? () async {
                      return;
                    }
                  : () {
                      return;
                    },
              child: _TracksList(snapshot.data ?? []),
            );
          },
        ),
      );
}

class _TracksList extends StatelessWidget {
  final List<Track> _tracks;

  _TracksList(this._tracks) : super();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _tracks.isEmpty ? 0.0 : 1.0,
      duration: Duration(milliseconds: 300),
      child: ListView.builder(
        itemCount: _tracks.length,
        itemBuilder: (context, index) => _SongTile(_tracks[index], index + 1),
      ),
    );
  }
}

class _SongTile extends ListTile {
  final Track _track;
  final int _position;

  _SongTile(this._track, this._position) : super();

  @override
  Widget build(BuildContext context) => Row(children: [
        Container(
          width: 36,
          alignment: Alignment.centerRight,
          child: Text(
            "$_position",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
          child: ListTile(
              title: Text(_track.name, overflow: TextOverflow.ellipsis, maxLines: 1),
              subtitle: Text(_track.artist),
              leading: Hero(
                tag: "${_track}_image",
                child: ClipOval(
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(_track.images[ImageSize.extralarge] ?? ''),
                  ),
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(_track)))),
        ),
      ]);
}
