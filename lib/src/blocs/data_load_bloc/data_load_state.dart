import '../../models/movie.dart';

abstract class DataLoadState {
  List<Movie> movies;
  DataLoadState(this.movies);
}

class DataLoadInitialState extends DataLoadState {
  DataLoadInitialState() : super([]);
}

class DataLoadInProgressState extends DataLoadState {
  DataLoadInProgressState(super.movies);
}

class DataLoadSuccessState extends DataLoadState {
  DataLoadSuccessState(super.movies);
}

class DataLoadFailureState extends DataLoadState {
  DataLoadFailureState(super.movies, this.error);

  final String error;
}

class DataFilteredState extends DataLoadState {
  DataFilteredState(super.movies);
}