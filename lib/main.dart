import 'package:film_reviewer/pages/HomePage.dart';
import 'package:film_reviewer/pages/MoviesListPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FilmReviewer());
}

class FilmReviewer extends StatelessWidget {
  const FilmReviewer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(52, 58, 64, 1)),
        // fontFamily: GoogleFonts.montserrat.toString(),
        useMaterial3: true,
      ),
      home: MovieListPage(),
    );
  }
}
