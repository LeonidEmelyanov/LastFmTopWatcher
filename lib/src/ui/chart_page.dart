import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/chart_model.dart';
import 'package:lol_kek/src/blocks/details_model.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/ui/details_page.dart';
import 'package:scoped_model/scoped_model.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('LastFM Top Songs'),
        ),
        body: ScopedModelDescendant<ChartModel>(
          builder: (context, widget, model) => RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => model.loadChart(),
                child: _TracksList(model.tracks),
              ),
        ),
      );
}

class _ErrorMessage extends StatelessWidget {
  final Exception _exception;

  const _ErrorMessage(this._exception) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              "Error",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
            Text(_exception?.toString()),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class _TracksList extends StatelessWidget {
  final List<Track> _tracks;

  const _TracksList(this._tracks) : super();

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
                      builder: (context) => ScopedModel(
                            model: DetailsModel(_track),
                            child: DetailsPage(),
                          ),
                    ),
                  )),
        ),
      ]);
}
