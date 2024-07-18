import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_state.dart';

import '../../models/movie.dart';
import 'data_load_event.dart';

class DataLoadBloc extends Bloc<DataLoadEvent, DataLoadState> {
  DataLoadBloc() : super(const DataLoadInitial()) {
    on<StartLoadingEvent>(_startLoading);
  }

  void _startLoading(
      StartLoadingEvent event, Emitter<DataLoadState> emit) async {
    emit(const DataLoadInProgress());

    var response = await http.get(Uri.parse(
        'https://movie-booking-app-f7e08-default-rtdb.firebaseio.com/movies.json'));

    if (response.statusCode == 200) {
      final List<Movie> movies = [];
      final List<dynamic> data = json.decode(response.body);
      for (final movie in data) {
        movies.add(Movie.fromJson(movie));
      }
      emit(DataLoadSuccess(movies));
    } else {
      emit(const DataLoadFailure('Failed to load data'));
    }
  }
}
