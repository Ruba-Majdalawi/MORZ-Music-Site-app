// artist.dart

class Artist {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String country;

  Artist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.country,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      country: json['country'],
    );
  }
}
