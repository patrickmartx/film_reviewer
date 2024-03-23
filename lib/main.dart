import 'package:film_reviewer/src/pages/home_page.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(52, 58, 64, 1)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
