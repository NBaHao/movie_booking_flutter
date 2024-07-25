import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Movie> movies;
  SearchBloc(this.movies) : super(SearchInitialState()) {
    on<SearchFetchEvent>(_seachingData);
  }

  void _seachingData(SearchFetchEvent event, Emitter<SearchState> emit) {
    List<Movie> searchedMovies = [];
    for (Movie movie in movies) {
      if (movie.name?.toLowerCase().contains(event.query.toLowerCase()) ?? false) {
        searchedMovies.add(movie);
      }
    }
    emit(SearchedDataState(searchedMovies));
  }
}