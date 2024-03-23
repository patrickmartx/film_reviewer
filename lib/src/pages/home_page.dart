import 'dart:ffi' as ffi;
import 'package:film_reviewer/src/data/http/http_client.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/repositories/genre_repository.dart';
import 'package:film_reviewer/src/data/repositories/movie_repository.dart';
import 'package:film_reviewer/src/pages/movies_list_page.dart';
import 'package:film_reviewer/src/stores/genre_store.dart';
import 'package:film_reviewer/src/stores/movie_home_DTO_store.dart';
import 'package:film_reviewer/src/utils/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final GenreRepositoryImpl genreRepository;
  late final MovieRepositoryImpl movieRepository;
  late final GenreStore genreStore;
  late final MovieHomeDTOStore movieStore;

  bool _isLoading = true;
  int indexSelectedGenre = 0;

  @override
  void initState() {
    super.initState();
    genreRepository = GenreRepositoryImpl(client: HttpClientImpl());
    movieRepository = MovieRepositoryImpl(client: HttpClientImpl());
    genreStore = GenreStore(repository: genreRepository);
    movieStore = MovieHomeDTOStore(repository: movieRepository);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Future.wait([genreStore.getGenres()]);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      Text("Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final genres = List<Genre>.from(genreStore.state.value ?? []);

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [genreStore.isLoading, genreStore.erro, genreStore.state]),
        builder: (context, child) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (genreStore.erro.value.isNotEmpty) {
            return Center(
              child: Text(genreStore.erro.value),
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
            final tabController = TabController(
                length: genreStore.state.value.length ?? 0, vsync: this);
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      "Filmes",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: const Color.fromRGBO(52, 58, 64, 1),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    sliver: SliverToBoxAdapter(
                      child: SearchBox(onChanged: (text) {
                        setState(() {});
                      }),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              for (int i = 0; i < genres.length; i++) ...[
                                _GenreButton(
                                  genreName: genres[i].genreName,
                                  isSelected: i == indexSelectedGenre,
                                  onPressed: () =>
                                      setState(() => indexSelectedGenre = i),
                                )
                              ],
                            ],
                          ),
                        ),
                        IndexedStack(
                          index: indexSelectedGenre,
                          children: genres.map((genre) {
                            return MoviesListPage(
                              idGenre: genre.id,
                              genres: genres,
                              movieRepository: movieRepository,
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

extension GenreButtonExtension on _GenreButton {
  Widget applyDecoration({BoxDecoration? decoration}) {
    return decoration == null
        ? this
        : Container(
            decoration: decoration,
            child: this,
          );
  }
}

class _GenreButton extends StatelessWidget {
  final String genreName;
  final bool isSelected;
  final VoidCallback onPressed;

  const _GenreButton({
    required this.genreName,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, 0),
          backgroundColor:
              isSelected ? const Color.fromRGBO(0, 56, 76, 1) : Colors.white,
          foregroundColor:
              isSelected ? Colors.white : const Color.fromRGBO(0, 56, 76, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: isSelected
                  ? Colors.transparent
                  : Color.fromRGBO(241, 243, 245, 1),
              width: 1.0,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          genreName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            color: isSelected ? Colors.white : const Color(0xFF00384C),
          ),
        ),
      ),
    );
  }
}
