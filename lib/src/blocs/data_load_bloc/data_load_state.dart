import '../../models/movie.dart';

abstract class DataLoadState {
  const DataLoadState();
}

class DataLoadInitial extends DataLoadState {
  const DataLoadInitial();
}

class DataLoadInProgress extends DataLoadState {
  const DataLoadInProgress();
}

class DataLoadSuccess extends DataLoadState {
  const DataLoadSuccess(this.movies);

  final List<Movie> movies;
}

class DataLoadFailure extends DataLoadState {
  const DataLoadFailure(this.error);

  final String error;
}