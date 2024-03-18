import 'package:film_reviewer/model/dummy/MovieListDummy.dart';
import 'package:film_reviewer/model/entity/Movie.dart';
import 'package:film_reviewer/utils/MovieCard.dart';
import 'package:film_reviewer/utils/MovieCardButtom.dart';
import 'package:film_reviewer/utils/SearchBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({super.key});
  final List<Movie> moviesList = MovieListDummy.moviesList;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    String searchedFilm = '';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            child: Text(
              "Filmes",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                height: 1.22,
                color: const Color.fromRGBO(52, 58, 64, 1),
              ),
            ),
          ),
          SearchBox(onChanged: (text) {
            setState(() {
              searchedFilm = text;
            });
          }),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
              genreBox(title: "Ação"),
              genreBox(title: "Aventura"),
              genreBox(title: "Fantasia"),
              genreBox(title: "Comédia")
            ],
          ),
          Wrap(
            runSpacing: 20.0,
            children: [
              for (final movie in widget.moviesList)
                MovieCardButtom(movie: movie),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 60))
        ],
      ),
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
