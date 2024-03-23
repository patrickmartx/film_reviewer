

class Movie {
  final int budget;
  final List<String> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final List<String> productionCompanies;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final double voteAverage;
  final String title;
  final List<String> cast;
  final List<String> directors;

  Movie(
      {required this.budget,
      required this.genres,
      required this.id,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.productionCompanies,
      required this.releaseDate,
      required this.revenue,
      required this.runtime,
      required this.voteAverage,
      required this.title,
      required this.cast,
      required this.directors});

  int getId() {
    return id;
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    final List castName = map['cast']
        .where((person) => person['known_for_department'] == 'Acting')
        .map((person) => person['name'])
        .toList();
    final List directorsName = map['cast']
        .where((person) =>
            person['known_for_department'] == "Directing" ||
            person['department'] == "Directing" ||
            person['job'] == "Director")
        .map((person) => person['name'])
        .toList();
    return Movie(
      budget: map['budget'],
      genres: List<String>.from(map['genres'].map((genre) => genre['name'])),
      id: map['id'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      productionCompanies: List<String>.from(
          map['production_companies'].map((genre) => genre['name'])),
      releaseDate: map['release_date'],
      revenue: map['revenue'] ?? 0,
      runtime: map['runtime'],
      voteAverage: map['vote_average'],
      title: map['title'],
      cast: List<String>.of(
        castName.map((e) => e.toString()),
      ).sublist(0, 5),
      directors: List<String>.of(
        directorsName.map((e) => e.toString()),
      ),
    );
  }
}
