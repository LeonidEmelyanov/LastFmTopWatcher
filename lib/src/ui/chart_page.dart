import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/chart_model.dart';
import 'package:lol_kek/src/blocks/details_model.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:lol_kek/src/ui/details_page.dart';

class ChartPage extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  StatelessElement createElement() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    final model = BlocProvider.of<ChartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('LastFM Top Songs'),
      ),
      body: StreamBuilder<List<Track>>(
        stream: model.tracksStream,
        builder: (context, snapshot) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => model.loadChart(),
              child: snapshot.hasError
                  ? _ErrorMessage(
                      refreshIndicatorState: _refreshIndicatorKey.currentState)
                  : _TracksList(snapshot?.data ?? []),
            ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final RefreshIndicatorState refreshIndicatorState;

  const _ErrorMessage({Key key, this.refreshIndicatorState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Oops, something went wrong",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Press button to refresh"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => refreshIndicatorState.show(),
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
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

class _SongTile extends StatelessWidget {
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
              title: Text(
                _track.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(_track.artist),
              leading: Hero(
                tag: "${_track}_image",
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                      builder: (context) => BlocProvider<DetailsBloc>(
                            creator: (context, bag) => DetailsBloc(_track),
                            child: DetailsPage(),
                          ),
                    ),
                  )),
        ),
      ]);
}
