import 'package:flutter/material.dart';
import 'package:lol_kek/track.dart';

class DetailsPage extends StatefulWidget {
  final Track _track;

  DetailsPage(this._track) : super();

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: Center(
          child: Text(widget._track.name),
        ),
      );
}
