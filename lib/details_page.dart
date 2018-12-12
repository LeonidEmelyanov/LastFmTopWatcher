import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage() : super();

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
          child: Text('Detail'),
        ),
      );
}
