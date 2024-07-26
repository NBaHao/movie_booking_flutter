import '../../models/movie.dart';

abstract class DataLoadState {
  String languageCode;
  List<Movie> movies;
  DataLoadState(this.movies, {required this.languageCode});
}

class DataLoadInitialState extends DataLoadState {
  DataLoadInitialState(super.movies, {required super.languageCode});
}

class DataLoadInProgressState extends DataLoadState {
  DataLoadInProgressState(super.movies, {required super.languageCode});
}

class DataLoadSuccessState extends DataLoadState {
  DataLoadSuccessState(super.movies, {required super.languageCode});
}

class DataLoadFailureState extends DataLoadState {
  DataLoadFailureState(super.movies, this.error, {required super.languageCode});

  final String error;
}