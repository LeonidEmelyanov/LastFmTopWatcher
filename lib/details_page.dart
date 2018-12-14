import 'package:flutter/material.dart';
import 'package:lol_kek/track.dart';

class DetailsPage extends StatefulWidget {
  final Track _track;

  DetailsPage(this._track) : super();

  @override
  State<StatefulWidget> createState() => DetailPageState(_track);
}

class DetailPageState extends State<DetailsPage> {
  final Track _track;

  DetailPageState(this._track);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
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
                          image:
                              NetworkImage(_track.images[ImageSize.extralarge]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              ],
          body: Center(
            child: Text("Album: ${_track.name}"),
          ),
        ),
      );
}
