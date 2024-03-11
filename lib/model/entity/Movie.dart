class Movie {
  final String posterUrl;
  final double rating;
  final String title;
  final String originalTitle;
  final int releaseYear;
  final double duration;
  final List<String> genres;
  final String description;
  final double budget;
  final String producer;
  final List<String> directos;
  final List<String> cast;

  Movie(
      {required this.posterUrl,
      required this.rating,
      required this.title,
      required this.originalTitle,
      required this.releaseYear,
      required this.duration,
      required this.genres,
      required this.description,
      required this.budget,
      required this.producer,
      required this.directos,
      required this.cast});
}
