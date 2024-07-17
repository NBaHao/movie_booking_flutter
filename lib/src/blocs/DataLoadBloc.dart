import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class DataLoadEvent {
  const DataLoadEvent();
}

class DataLoadBloc extends Bloc<DataLoadEvent, List<Movie>> {
  DataLoadBloc() : super([]) {
    on<DataLoadEvent>((event, emit) async {
      emit(await _loadData());
    });
  }

  Future<List<Movie>> _loadData() async {
    final response = await http.get(Uri.parse(
        'https://movie-booking-app-f7e08-default-rtdb.firebaseio.com/movies.json'));
    if (response.statusCode == 200) {
      final List<Movie> movies = [];
      final List<dynamic> data = json.decode(response.body);
      for (final movie in data) {
        movies.add(Movie.fromJson(movie));
      }
      return movies;
    } else {
      throw Exception('Failed to load data');
    }
  }
}