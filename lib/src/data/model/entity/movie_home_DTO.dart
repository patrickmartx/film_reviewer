import 'package:film_reviewer/src/data/http/http_client.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/repositories/genre_repository.dart';

class MovieHomeDTO {
  final List<int> genresID;
  final int id;
  final String posterPath;
  final String title;

  MovieHomeDTO(
      {required this.genresID,
      required this.id,
      required this.posterPath,
      required this.title});

  factory MovieHomeDTO.fromMap(Map<String, dynamic> map) {
    final genreIds = List<int>.from(map['genre_ids'] as List);
    final List<int> displayedGenres;

    if (genreIds.length > 1) {
      displayedGenres = genreIds.sublist(0, 2);
    } else {
      displayedGenres = genreIds;
    }
    
    return MovieHomeDTO(
      genresID: displayedGenres,
      id: map['id'],
      posterPath: map['poster_path'],
      title: map['title'],
    );
  }
}
