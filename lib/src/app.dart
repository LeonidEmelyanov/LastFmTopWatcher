import 'package:flutter/services.dart';
import 'package:lol_kek/src/blocks/chart_bloc.dart';
import 'package:lol_kek/src/blocks/details_bloc.dart';
import 'package:lol_kek/src/themes.dart';
import 'package:lol_kek/src/ui/details_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_kek/src/ui/chart_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: 'LastFM Top Tracks',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: AppColors.accentColor,
        canvasColor: Colors.transparent,
      ),
      initialRoute: "/",
      routes: {
        '/': (builder) => ChangeNotifierProvider.value(
              value: ChartBloc(),
              child: ChartPage(),
            ),
        '/details': (builder) => ChangeNotifierProvider.value(
              value: DetailsBloc(),
              child: DetailsPage(),
            ),
      },
    );
  }
}
