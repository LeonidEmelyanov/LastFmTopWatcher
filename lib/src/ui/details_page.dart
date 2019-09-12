import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/details_bloc.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer<DetailsBloc>(
          builder: (context, bloc, __) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(bloc.track.artist),
                    centerTitle: true,
                    background: Hero(
                      tag: "${bloc.track}_image",
                      child: Container(
                        child: Image(
                            image: NetworkImage(
                                bloc.track.images[ImageSize.extralarge]),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter),
                      ),
                    ),
                  ),
                )
              ],
              body: Center(
                child: Text("Album: ${bloc.track.name}"),
              ),
            ),
        ),
      );
}
