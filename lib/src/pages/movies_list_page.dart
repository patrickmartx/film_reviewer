import 'package:film_reviewer/src/data/http/http_client.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/model/entity/movie_home_DTO.dart';
import 'package:film_reviewer/src/data/repositories/genre_repository.dart';
import 'package:film_reviewer/src/data/repositories/movie_repository.dart';
import 'package:film_reviewer/src/stores/genre_store.dart';
import 'package:film_reviewer/src/stores/movie_home_DTO_store.dart';
import 'package:film_reviewer/src/utils/movie_card_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviesListPage extends StatefulWidget {
  final int idGenre;
  final List<Genre> genres;
  final MovieRepositoryImpl movieRepository;

  const MoviesListPage({
    Key? key,
    required this.idGenre,
    required this.genres,
    required this.movieRepository,
  }) : super(key: key);

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  late final MovieHomeDTOStore movieStore;
  late final GenreStore genreStore;

  bool _isLoading = true;
  List<MovieHomeDTO> movies = [];

  @override
  void initState() {
    super.initState();
    movieStore = MovieHomeDTOStore(repository: widget.movieRepository);
    genreStore =
        GenreStore(repository: GenreRepositoryImpl(client: HttpClientImpl()));
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Future.wait(
          [movieStore.getMoviesTwo(widget.idGenre), genreStore.getGenres()]);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      Text("Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    movies = List.from(movieStore.state.value ?? []);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: AnimatedBuilder(
          animation: Listenable.merge([
            movieStore.isLoading,
            movieStore.erro,
            movieStore.state,
            genreStore.isLoading,
            genreStore.erro,
            genreStore.state
          ]),
          builder: (context, child) {
            if (_isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (movieStore.erro.value.isNotEmpty) {
              return Center(
                child: Text(movieStore.erro.value),
              );
            }

            if (genreStore.erro.value.isNotEmpty) {
              return Center(
                child: Text(genreStore.erro.value),
              );
            }

            if (movieStore.state.value.isEmpty) {
              return const Center(
                child: Text("Nenhum item na lista"),
              );
            }

            if (genreStore.state.value == null) {
              return const Center(child: Text("Carregando gêneros..."));
            }

            if (genreStore.state.value.isEmpty) {
              return const Center(
                child: Text("Gênero não carregado."),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index >= movies.length)
                    return null;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MovieCardButtom(movie: movies[index], genres: widget.genres,),
                  );
                },
                itemCount: movies.length,
                physics: const BouncingScrollPhysics(),
              );
            }
          },
        ),
      ),
    );
  }
}
