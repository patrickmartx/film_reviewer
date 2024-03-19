import 'package:film_reviewer/src/data/http/Exceptions.dart';
import 'package:film_reviewer/src/data/model/entity/Movie.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailsStore {
  final MovieRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<Movie?> movie = ValueNotifier<Movie?>(null);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  MovieDetailsStore({required this.repository});

  Future<void> getMovieDetailsById(int id) async {
    isLoading.value = true;

    try {
      final movieDetails = await repository.getMovieDetailsById(id);
      movie.value = movieDetails;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } on Exception catch (e) {
      erro.value = 'Não foi possível carregar detalhes do filme.';
    } finally {
      isLoading.value = false;
    }
  }
}