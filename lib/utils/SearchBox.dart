import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  String searchedFilm = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        searchedFilm = text;
      },
      style: const TextStyle(
        color: Color.fromRGBO(134, 142, 150, 1),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(241, 243, 245, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide.none,
        ),
        hintText: "Pesquise filmes",
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
