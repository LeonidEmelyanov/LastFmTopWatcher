class Track {
  final String name;
  final String artist;
  final Images images;
  final Duration duration;
  final Album album;
  final Wiki trackWiki;

  Track({this.name, this.artist, this.images, this.duration, this.album, this.trackWiki});

  Track.fromJson(dynamic json)
      : name = json['name'],
        artist = json['artist']['name'],
        images = Images.fromJson(json['image']),
        duration = Duration(seconds: int.parse(json['duration'])),
        album = Album.fromJson(json['album'] ?? {}),
        trackWiki = Wiki.fromJson(json['wiki'] ?? {});

  @override
  String toString() => "$name $artist";
}

class Album {
  final String artist;
  final String title;
  final String url;
  final Images images;

  Album({this.artist, this.title, this.url, this.images});

  Album.fromJson(dynamic json)
      : artist = json['artist'],
        title = json['title'],
        url = json['url'],
        images = Images.fromJson(json['image'] ?? []);
}

class Wiki {
  final DateTime published;
  final String summary;
  final String content;
  final Images images;

  Wiki({this.published, this.summary, this.content, this.images}) : super();

  Wiki.fromJson(dynamic json)
      : published = json['published'],
        summary = json['summary'],
        content = json['content'],
        images = Images.fromJson(json['image'] ?? []);
}

class Images {
  final Map<ImageSize, String> images;

  Images({this.images});

  Images.fromJson(dynamic json)
      : images = Map.fromIterable(
          json,
          key: (v) => ImageSize.values.firstWhere((item) => item.toString() == "ImageSize.${v['size']}"),
          value: (v) => v['#text'],
        );

  String operator [](ImageSize size) => images[size];
}

enum ImageSize { small, medium, large, extralarge }
