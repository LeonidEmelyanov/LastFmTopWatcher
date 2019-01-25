import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/details_model.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ScopedModelDescendant<DetailsModel>(
          builder: (context, child, model) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(model.track.artist),
                          centerTitle: true,
                          background: Hero(
                            tag: "${model.track}_image",
                            child: Container(
                              child: Image(
                                image: NetworkImage(
                                    model.track.images[ImageSize.extralarge]),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                body: Center(
                  child: Text("Album: ${model.track.name}"),
                ),
              ),
        ),
      );
}
