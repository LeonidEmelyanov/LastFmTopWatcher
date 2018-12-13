class Track {
  final String name;
  final String artist;
  final String imgUrl;
  final Duration duration;

  final TrackWiki trackWiki;

  Track({this.name, this.artist, this.imgUrl, this.duration, this.trackWiki});

  Track.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        artist = json['artist']['name'],
        imgUrl = json['image'][3]["#text"],
        duration = Duration(seconds: int.parse(json['duration'])),
        trackWiki = TrackWiki.fromJson(json['wiki'] ?? Map.identity());
}

class TrackWiki {
  final DateTime published;
  final String summary;
  final String content;

  TrackWiki({this.published, this.summary, this.content}) : super();

  TrackWiki.fromJson(Map<String, dynamic> json)
      : published = json['published'],
        summary = json['summary'],
        content = json['content'];
}
