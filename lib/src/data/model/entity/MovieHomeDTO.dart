import 'dart:ffi';

import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/model/entity/Genre.dart';
import 'package:film_reviewer/src/data/repositories/GenreRepository.dart';

class MovieHomeDTO {
  final List<Future<Genre>> genres;
  final int id;
  final String posterPath;
  final String title;

  MovieHomeDTO(
      {required this.genres,
      required this.id,
      required this.posterPath,
      required this.title});

  factory MovieHomeDTO.fromMap(Map<String, dynamic> map) {
    final genreIds = List<int>.from(map['genre_ids'] as List);
    GenreRepositoryImpl repository =
        GenreRepositoryImpl(client: HttpClientImpl());
    return MovieHomeDTO(
      genres:
          List<Future<Genre>>.from(genreIds.map((e) => repository.getById(e))),
      id: map['id'],
      posterPath: map['poster_path'],
      title: map['title'],
    );
  }
}
