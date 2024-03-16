import 'dart:ffi';

import 'package:film_reviewer/model/dummy/MovieListDummy.dart';
import 'package:film_reviewer/model/entity/Movie.dart';
import 'package:film_reviewer/utils/SearchBox.dart';
import 'package:film_reviewer/utils/MovieCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedFilm = '';
  String pageName = 'Filmes';
  List<Movie> moviesList = List.from(MovieListDummy.moviesList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          pageName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            height: 1.22,
            color: const Color.fromRGBO(52, 58, 64, 1),
            //rgba(52, 58, 64, 1)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
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
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: moviesList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10),
                    child: MovieCard(movie: moviesList.elementAt(index)),
                  ),
                ),
              ),
            ],
          ),
        ),
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
