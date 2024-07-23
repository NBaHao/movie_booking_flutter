import 'package:movie_booking/src/models/movie.dart';

abstract class SearchState {
  List<Movie> movies;
  SearchState(this.movies);
}

class SearchInitialState extends SearchState {
  SearchInitialState() : super([]);
}

class SearchedDataState extends SearchState {
  SearchedDataState(super.movies);
}