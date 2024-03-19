import 'dart:ffi';

class Genre {
  final int id;
  final String genreName;

  Genre({required this.id, required this.genreName});

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(id: map['id'], genreName: map['name']);
  }

  String getGenre() {
    return this.genreName;
  }
}
