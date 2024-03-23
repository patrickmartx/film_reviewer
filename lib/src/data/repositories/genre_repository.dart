import 'dart:convert';

import 'package:film_reviewer/src/data/http/exceptions.dart';
import 'package:film_reviewer/src/data/http/http_client.dart';
import 'package:film_reviewer/src/data/http/routes.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> getGenres();
  Future<Genre> getById(int genreId);
}

class GenreRepositoryImpl implements GenreRepository {
  final HttpClientImpl client;

  GenreRepositoryImpl({required this.client});

  @override
  Future<List<Genre>> getGenres() async {
    final response = await client.get(url: Routes().routeGenresList());

    if (response.statusCode == 200) {
      final List<Genre> genres = [];

      final body = jsonDecode(response.body);

      body['genres'].map((content) {
        final Genre genre = Genre.fromMap(content);
        genres.add(genre);
      }).toList();

      return genres;
    } else if (response.statusCode == 404) {
      throw NotFoundException(
          message:
              "Lista de generos não encontrada. Verifique a URL informada.");
    } else {
      throw Exception("Não foi possível carregar os filmes");
    }
  }
  
  @override
  Future<Genre> getById(int genreId) async {
    final response = await client.get(url: Routes().routeGenreById(genreId));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Genre.fromMap(body);
    } else {
      throw Exception("Failed to get genre with ID: $genreId");
    }
  }
}
