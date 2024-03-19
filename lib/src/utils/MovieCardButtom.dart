import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/http/Routes.dart';
import 'package:film_reviewer/src/data/model/entity/Genre.dart';
import 'package:film_reviewer/src/data/model/entity/MovieHomeDTO.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:film_reviewer/src/pages/MovieDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCardButtom extends StatelessWidget {
  const MovieCardButtom({super.key, required this.movie});
  final MovieHomeDTO movie;

  @override
  Widget build(BuildContext context) {
    MovieRepository repository = MovieRepositoryImpl(client: HttpClientImpl());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              id: movie.id,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 320.0,
            height: 470.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black,
            ),
          ),
          Stack(
            children: [
              Container(
                width: 320.0,
                height: 440.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    Routes().routePoster(movie.posterPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 320.0,
                  height: 162.33,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent.withOpacity(0.63),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 100, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Row(
                              children: movie.genres
                                  .map((genero) => FutureBuilder<Genre>(
                                        future: genero,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final genre = snapshot.data!;
                                            return Text(
                                              genre == movie.genres.last
                                                  ? genre.getGenre()
                                                  : "${genre.getGenre()} - ",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text(
                                                "Erro ao carregar genero");
                                          } else {
                                            return const Text("Carregando...");
                                          }
                                        },
                                      ))
                                  .toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
