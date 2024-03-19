import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/http/Routes.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:film_reviewer/src/stores/MovieHomeDTOStore.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
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
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 32,
                    ),
                padding: const EdgeInsets.all(16),
                itemCount: store.state.value.length,
                itemBuilder: (_, index) {
                  final movie = store.state.value[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          Routes().routePoster(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          movie.title
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
