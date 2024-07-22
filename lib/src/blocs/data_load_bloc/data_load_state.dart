import '../../models/movie.dart';

abstract class DataLoadState {
  List<Movie> movies;
  DataLoadState(this.movies);
}

class DataLoadInitial extends DataLoadState {
  DataLoadInitial() : super([]);
}

class DataLoadInProgress extends DataLoadState {
  DataLoadInProgress(super.movies);
}

class DataLoadSuccess extends DataLoadState {
  DataLoadSuccess(super.movies);
}

class DataLoadFailure extends DataLoadState {
  DataLoadFailure(super.movies, this.error);

  final String error;
}