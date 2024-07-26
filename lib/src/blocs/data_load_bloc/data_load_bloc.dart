import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_state.dart';

import '../../models/movie.dart';
import 'data_load_event.dart';

class DataLoadBloc extends Bloc<DataLoadEvent, DataLoadState> {
  DataLoadBloc() : super(DataLoadInitialState([], languageCode: 'en')) {
    on<StartLoadingEvent>(_startLoading);
    on<SetLanguageEvent>(_setLanguage);
  }

  void _startLoading(
      StartLoadingEvent event, Emitter<DataLoadState> emit) async {
    emit(DataLoadInProgressState([], languageCode: state.languageCode));
    var response = await http.get(Uri.parse("https://movie-booking-app-f7e08-default-rtdb.firebaseio.com/${state.languageCode}/movies.json"));

    if (response.statusCode == 200) {
      final List<Movie> movies = [];
      final List<dynamic> data = json.decode(response.body);
      for (final movie in data) {
        movies.add(Movie.fromJson(movie));
      }
      emit(DataLoadSuccessState(movies, languageCode: state.languageCode));
    } else {
      emit(DataLoadFailureState([], 'Failed to load data', languageCode: state.languageCode));
    }
  }

  FutureOr<void> _setLanguage(SetLanguageEvent event, Emitter<DataLoadState> emit) {
    state.languageCode = event.languageCode;
  }
}
