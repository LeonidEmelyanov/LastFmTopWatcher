import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/chart_model.dart';
import 'package:lol_kek/src/ui/chart_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<ChartBloc>(
        creator: (context, bag) => ChartBloc(),
        child: ChartPage(),
      ),
    );
  }
}
