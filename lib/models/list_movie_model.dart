import 'package:movie_ticket/models/movie_model.dart';

class ListMovieModel {
  String id;
  String listName;
  List<MovieReference> movies;

  ListMovieModel(
      {required this.id, required this.listName, required this.movies});

  factory ListMovieModel.fromJson(Map<String, dynamic> json) {
    return ListMovieModel(
        id: json['_id'],
        listName: json['listName'],
        movies: json['movies']
            .map<MovieReference>((movie) => MovieReference.fromJson(movie))
            .toList());
  }
}

class MovieReference {
  String id;
  String title;
  String posterPath;
  Rated rated;

  MovieReference(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.rated});

  factory MovieReference.fromJson(Map<String, dynamic> json) {
    return MovieReference(
        id: json['_id'],
        title: json['title'],
        posterPath: 'https://image.tmdb.org/t/p/w300' + json['posterPath'],
        rated: Rated.fromJson(json['rated']));
  }
}
