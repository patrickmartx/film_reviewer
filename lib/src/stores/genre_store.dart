import 'package:film_reviewer/src/data/http/exceptions.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/repositories/genre_repository.dart';
import 'package:flutter/cupertino.dart';

class GenreStore {
  final GenreRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<Genre>> state = ValueNotifier<List<Genre>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  GenreStore({required this.repository});

  Future getGenres() async {
    isLoading.value = true;

    try {
      final result = await repository.getGenres();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
