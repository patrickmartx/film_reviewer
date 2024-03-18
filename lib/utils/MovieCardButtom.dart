import 'package:film_reviewer/model/entity/Movie.dart';
import 'package:film_reviewer/pages/MovieDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCardButtom extends StatelessWidget {
  const MovieCardButtom({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movie: movie,
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
                    movie.posterUrl,
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
                        Row(
                          children: movie.genres
                              .map(
                                (genero) => Text(
                                  genero == movie.genres.last
                                      ? genero
                                      : "$genero - ",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                              )
                              .toList(),
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
