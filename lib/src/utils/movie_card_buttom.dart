import 'package:film_reviewer/src/data/http/routes.dart';
import 'package:film_reviewer/src/data/model/entity/genre.dart';
import 'package:film_reviewer/src/data/model/entity/movie_home_DTO.dart';
import 'package:film_reviewer/src/pages/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCardButtom extends StatelessWidget {
  const MovieCardButtom({
    Key? key,
    required this.movie,
    required this.genres,
  }) : super(key: key);

  final MovieHomeDTO movie;
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    List<String> genreNames = _getGenreNames();

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
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 250.0,
                          ),
                          child: Text(
                            genreNames.join(
                                ' - '),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
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

  List<String> _getGenreNames() {
    return movie.genresID.map((genreId) {
      final genre = genres.firstWhere((genre) => genre.id == genreId,
          orElse: () => Genre(id: genreId, genreName: 'Unknown'));
      return genre.genreName;
    }).toList();
  }
}
