import 'package:film_reviewer/src/data/http/Exceptions.dart';
import 'package:film_reviewer/src/data/model/entity/MovieHomeDTO.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:flutter/cupertino.dart';

class MovieHomeDTOStore {
  final MovieRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<MovieHomeDTO>> state = ValueNotifier<List<MovieHomeDTO>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  MovieHomeDTOStore({required this.repository});

  Future getMovies() async {
    isLoading.value = true;

    try {
      final result = await repository.getMovies();
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