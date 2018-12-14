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
  final _tracks = List<Track>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _loadChart();
  }

  Future<void> _loadChart() async {
    setState(() {
      _refreshIndicatorKey.currentState?.show();
      _tracks.clear();
    });

    return _loader.getChart().then((tracks) => setState(() {
          _tracks.addAll(tracks);
        }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('LastFM Top Songs'),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () => _loadChart(),
          child: AnimatedOpacity(
            opacity: _tracks.isEmpty ? 0.0 : 1.0,
            duration: Duration(milliseconds: 300),
            child: ListView.builder(
              itemCount: _tracks.length,
              itemBuilder: (context, index) =>
                  _SongTile(_tracks[index], index + 1),
            ),
          ),
        ),
      );
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
              title: Text(_track.name,
                  overflow: TextOverflow.ellipsis, maxLines: 1),
              subtitle: Text(_track.artist),
              leading: Hero(
                tag: "${_track}_image",
                child: ClipOval(
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Image.network(
                        _track.images[ImageSize.extralarge] ?? ''),
                  ),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(_track)))),
        ),
      ]);
}
