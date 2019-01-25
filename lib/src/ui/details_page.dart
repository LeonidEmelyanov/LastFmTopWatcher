import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/bloc_provider.dart';
import 'package:lol_kek/src/blocks/details_bloc.dart';
import 'package:lol_kek/src/models/track.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage() : super();

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailsPage> {
  DetailsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<DetailsBloc>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.trackInfo,
        builder: (BuildContext context, AsyncSnapshot<Track> snapshot) {
          var _track = snapshot.data ?? Track();

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(_track.artist),
                      centerTitle: true,
                      background: Hero(
                        tag: "${_track}_image",
                        child: Container(
                          child: Image(
                            image: NetworkImage(
                                _track.images[ImageSize.extralarge]),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
            body: Center(
              child: Text("Album: ${_track.name}"),
            ),
          );
        },
      ),
    );
  }
}
