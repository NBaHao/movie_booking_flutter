import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchEventFetch>(_seachingData);
  }

  void _seachingData(SearchEventFetch event, Emitter<SearchState> emit) {
    List<Movie> searchedMovies = [];
    for (Movie movie in event.movies) {
      if (movie.name!.toLowerCase().contains(event.query.toLowerCase())) {
        searchedMovies.add(movie);
      }
    }
    emit(SearchedDataState(searchedMovies));
  }
}