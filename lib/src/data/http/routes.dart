import 'package:film_reviewer/api/api_key.dart';

class Routes {
  final _mainUrl = "https://api.themoviedb.org/3";
  final _apiKey = APIKEY;


  String routeMovieList(int id) {
    return "$_mainUrl/discover/movie?with_genres=$id&language=pt-br&api_key=$_apiKey";
  }

  String routeMovieDetail(int id) {
    return "$_mainUrl/movie/${id.toString()}?language=pt-br&api_key=$_apiKey";
  }

  String routeMovieCredits(int id) {
    return "$_mainUrl/movie/${id.toString()}/credits?language=pt-br&api_key=$_apiKey";
  }

  String routeGenresList() {
    return "$_mainUrl/genre/movie/list?language=pt-br&api_key=$_apiKey";
  }
  

  String routeGenreById(int id) {
    return "$_mainUrl/genre/${id.toString()}?api_key=$_apiKey&language=pt-BR";
  }

  String routePoster(String path) {
    return "https://image.tmdb.org/t/p/w600_and_h900_bestv2$path";
  }
}
