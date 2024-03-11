import 'package:film_reviewer/model/entity/movie.dart';
import 'package:film_reviewer/utils/SearchBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pageName = 'Filmes';
  
  static List<Movie> moviesList = [

    Movie(
        posterUrl:
            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg",
        rating: 73.0,
        title: "Donzela",
        originalTitle: "Damsel",
        releaseYear: 2024,
        duration: 1.50,
        genres: ["Fantasia", "Aventura", "Ação"],
        description:
            "O casamento de uma jovem com um príncipe encantado se transforma em uma luta por sobrevivência quando ela é oferecida em sacrifício a um dragão que cospe fogo.",
        budget: 60000000.00,
        producer: "Netflix",
        directos: ["Juan Carlos Fresnadillo"],
        cast: ["Millie Bobby Brown", "Ray Winstone", "Angela Bassett", "Brooke Carter"]
        ),
  ];

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
            color: Color.fromRGBO(52, 58, 64, 1),
            //rgba(52, 58, 64, 1)
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),

            Container(
              child: SearchBox(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(),
            Expanded(
                child: ListView.builder(
                    itemCount: moviesList.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(moviesList[index].title),
                        ))),
            // Container(
            //   child: SearchBar(
            //     leading: Icon(Icons.search),
            //     hintText: 'Pesquise filmes',
            //   ),
            // )
          ]),
    );
  }
}
