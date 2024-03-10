import 'package:film_reviewer/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FilmReviewer());
}

class FilmReviewer extends StatelessWidget {
  const FilmReviewer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(52, 58, 64, 1)),
        // fontFamily: GoogleFonts.montserrat.toString(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
