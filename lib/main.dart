import 'package:flutter/material.dart';
import 'package:lol_kek/chart_page.dart';
import 'package:lol_kek/details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChartPage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}
