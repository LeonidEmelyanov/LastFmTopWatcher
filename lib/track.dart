class Track {
  final String name;
  final String artist;
  final Images images;
  final Duration duration;
  final Wiki trackWiki;

  Track({this.name, this.artist, this.images, this.duration, this.trackWiki});

  Track.fromJson(dynamic json)
      : name = json['name'],
        artist = json['artist']['name'],
        images = Images.fromJson(json['image']),
        duration = Duration(seconds: int.parse(json['duration'])),
        trackWiki = Wiki.fromJson(json['wiki'] ?? Map.identity());

  @override
  String toString() => "$name $artist";
}

class Album {
  final String artist;
  final String title;
  final String url;

  Album({this.artist, this.title, this.url});
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

  Images.fromJson(dynamic json) : images = _getImageSizes(json);

  String operator [](ImageSize size) => images[size];

  static Map<ImageSize, String> _getImageSizes(List<dynamic> images) {
    final result = Map<ImageSize, String>();

    images.forEach((image) => result.putIfAbsent(
        ImageSize.values.firstWhere(
            (item) => item.toString() == "ImageSize.${image['size']}"),
        () => image['#text']));
    return result;
  }
}

enum ImageSize { small, medium, large, extralarge }
