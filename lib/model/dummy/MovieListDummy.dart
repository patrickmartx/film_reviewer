import 'package:film_reviewer/model/entity/Movie.dart';

class MovieListDummy {
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
      cast: [
        "Millie Bobby Brown",
        "Ray Winstone",
        "Angela Bassett",
        "Brooke Carter"
      ],
    ),
    Movie(
      posterUrl:
          "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
      rating: 70.8,
      title: "Duna",
      originalTitle: "Dune",
      releaseYear: 2021,
      duration: 2.36,
      genres: ["Ficção Científica", "Aventura", "Drama"],
      description:
          "Paul Atreides, um jovem brilhante e talentoso nascido em um grande destino além de sua compreensão, deve viajar para o planeta mais perigoso do universo para garantir o futuro de sua família e seu povo.",
      budget: 165000000.00,
      producer: "Legendary Pictures",
      directos: ["Denis Villeneuve"],
      cast: [
        "Timothée Chalamet",
        "Rebecca Ferguson",
        "Oscar Isaac",
        "Josh Brolin"
      ],
    ),
    Movie(
    posterUrl:
        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/74xTEgt7R36Fpooo50r9T25onhq.jpg",
    rating: 70.9,
    title: "Batman",
    originalTitle: "The Batman",
    releaseYear: 2022,
    duration: 2.55,
    genres: ["Ação", "Crime", "Thriller"],
    description:
        "Após dois anos investigando a criminalidade de Gotham City, Batman se depara com um serial killer conhecido como Charada, que desafia a elite de Gotham.",
    budget: 185000000.00,
    producer: "Warner Bros. Pictures",
    directos: ["Matt Reeves"],
    cast: ["Robert Pattinson", "Zoë Kravitz", "Paul Dano", "Jeffrey Wright", "Colin Farrell"],
  ),
  ];
}
