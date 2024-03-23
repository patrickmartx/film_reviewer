import 'package:film_reviewer/src/data/http/exceptions.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/model/entity/movie_home_DTO.dart';
import 'package:film_reviewer/src/data/repositories/movie_repository.dart';
import 'package:flutter/cupertino.dart';

class MovieHomeDTOStore {
  final MovieRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<MovieHomeDTO>> state = ValueNotifier<List<MovieHomeDTO>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  MovieHomeDTOStore({required this.repository});

  Future getMoviesTwo(int idGenre) async {
    isLoading.value = true;
    try {
      final result = await repository.getMovies(idGenre);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    }
    catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}


