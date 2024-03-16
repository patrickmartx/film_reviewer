import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onChanged;

  const SearchBox({super.key, required this.onChanged});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String searchedFilm = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      height: 47.0,
      child: TextField(
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
      ),
    );
  }
}
