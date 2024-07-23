import '../../models/movie.dart';

abstract class SearchEvent {}

class SearchEventFetch extends SearchEvent {
  final List<Movie> movies;
  final String query;
  SearchEventFetch(this.query, this.movies);
}