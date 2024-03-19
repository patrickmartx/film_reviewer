import 'dart:convert';
import 'dart:io';

import 'package:film_reviewer/src/data/http/Exceptions.dart';
import 'package:film_reviewer/src/data/http/Routes.dart';
import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/model/entity/Movie.dart';
import 'package:film_reviewer/src/data/model/entity/MovieHomeDTO.dart';

abstract class MovieRepository {
  Future<List<MovieHomeDTO>> getMovies();
  Future<Movie> getMovieDetailsById(int id);
}

class MovieRepositoryImpl implements MovieRepository {
  final HttpClientImpl client;

  MovieRepositoryImpl({required this.client});

  @override
  Future<List<MovieHomeDTO>> getMovies() async {
    final response = await client.get(url: Routes().routeMovieList());

    if (response.statusCode == 200) {
      final List<MovieHomeDTO> movieList = [];

      final body = jsonDecode(response.body);

      body['results'].map((content) {
        final MovieHomeDTO movie = MovieHomeDTO.fromMap(content);
        movieList.add(movie);
      }).toList();

      return movieList;
    } else if (response.statusCode == 404) {
      throw NotFoundException(
          message:
              "Lista de filmes não encontrada. Verifique a URL informada.");
    } else {
      throw Exception("Não foi possível carregar os filmes");
    }
  }

  @override
  Future<Movie> getMovieDetailsById(int id) async {
    final movieDetailsResponse = await client.get(
      url: Routes().routeMovieDetail(id),
    );

    if (movieDetailsResponse.statusCode == 200) {
      final detailsBody = jsonDecode(movieDetailsResponse.body);

      final creditsResponse = await client.get(
        url: Routes().routeMovieCredits(id),
      );

      final creditsBody = creditsResponse.statusCode == 200
          ? jsonDecode(creditsResponse.body)
          : {Exception("Erro ao carregar crédito.")}; 

      final combinedData = Map<String, dynamic>.from(detailsBody);
      combinedData.addAll(creditsBody);

      final movie = Movie.fromMap(combinedData);
      return movie;
    } else if (movieDetailsResponse.statusCode == 404) {
      throw NotFoundException(
          message: "Filme não encontrado. Verifique o ID informado.");
    } else {
      throw Exception("Não foi possível carregar filme");
    }
  }
}
