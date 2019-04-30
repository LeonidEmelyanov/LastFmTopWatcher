import 'package:lol_kek/src/blocks/chart_bloc.dart';
import 'package:lol_kek/src/blocks/details_bloc.dart';
import 'package:lol_kek/src/ui/details_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_kek/src/ui/chart_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (builder) => StatefulProvider<ChartBloc>(
              valueBuilder: (context) => ChartBloc(),
              onDispose: (context, bloc) => bloc.dispose(),
              child: ChartPage(),
            ),
        '/details': (builder) => StatefulProvider<DetailsBloc>(
              valueBuilder: (context) => DetailsBloc(),
              onDispose: (context, bloc) => bloc.dispose(),
              child: DetailsPage(),
            ),
      },
    );
  }
}
