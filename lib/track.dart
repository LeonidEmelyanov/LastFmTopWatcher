class Track {
  final String name;
  final String artist;
  final String imgUrl;
  final Duration duration;

  Track({this.name, this.artist, this.imgUrl, this.duration});

  Track.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        artist = json['artist']['name'],
        imgUrl = json['image'][3]["#text"],
        duration = Duration(seconds: int.parse(json['duration']));
}

class TrackInfo extends Track {
  final DateTime published;
  final String summary;
  final String content;

  TrackInfo(
      {String name,
      String artist,
      String imgUrl,
      String duration,
      this.published,
      this.summary,
      this.content})
      : super();

  TrackInfo.fromJson(Map<String, dynamic> json)
      : published = json['published'],
        summary = json['summary'],
        content = json['content'];
}
