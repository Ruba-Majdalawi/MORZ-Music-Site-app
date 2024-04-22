// song.dart

class Song {
  final String id;
  final String title;
  final String type;
  final String price;
  final dynamic artistId;

  Song({
    required this.id,
    required this.title,
    required this.type,
    required this.price,
    required this.artistId,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      price: json['price'],
      artistId: json['artistId'] ,
    );
  }
}
