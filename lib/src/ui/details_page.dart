import 'package:flutter/material.dart';
import 'package:lol_kek/src/blocks/details_model.dart';
import 'package:lol_kek/src/models/track.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DetailsBloc>(context);

    return Scaffold(
      body: StreamBuilder<Track>(
        initialData: model.initialData,
        stream: model.trackStream,
        builder: (context, snapshot) {
          final track = snapshot.data;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(track.artist),
                      centerTitle: true,
                      background: Hero(
                        tag: "${track}_image",
                        child: Container(
                          child: Image(
                            image: NetworkImage(
                                track.images[ImageSize.extralarge]),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
            body: Center(
              child: Text("Album: ${track.name}"),
            ),
          );
        },
      ),
    );
  }
}
