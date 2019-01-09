import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_kek/chart_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChartPage(),
    );
  }
}
