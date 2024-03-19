import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:film_reviewer/src/stores/MovieHomeDTOStore.dart';
import 'package:film_reviewer/src/utils/MovieCardButtom.dart';
import 'package:film_reviewer/src/utils/SearchBox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieHomeDTOStore store = MovieHomeDTOStore(
    repository: MovieRepositoryImpl(
      client: HttpClientImpl(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    String searchedFilm = '';

    return Scaffold(
      body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(store.erro.value),
              );
            }

            if (store.state.value.isEmpty) {
              return const Center(
                child: Text("Nenhum item na lista"),
              );
            } else {
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
                          height: 1.22,
                          color: const Color.fromRGBO(52, 58, 64, 1),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      sliver: SliverToBoxAdapter(
                        child: SearchBox(onChanged: (text) {
                          setState(() {
                            searchedFilm = text;
                          });
                        }),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                          genreBox(title: "Ação"),
                          genreBox(title: "Aventura"),
                          genreBox(title: "Fantasia"),
                          genreBox(title: "Comédia"),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MovieCardButtom(movie: store.state.value[index]),
                        ),
                        childCount: store.state.value.length,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class genreBox extends StatelessWidget {
  const genreBox({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 79.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromRGBO(241, 243, 245, 1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(0, 56, 76, 1),
          fontSize: 12.0,
        ),
      ),
    );
  }
}
