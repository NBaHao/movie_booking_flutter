import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_state.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/flitering_event.dart';

class FilteringBloc extends Bloc<FliteringEvent, FilteringState> {
  FilteringBloc() : super(FilteringState(false)) {
    on<FliteringEvent>(_setFiltering);
  }

  void _setFiltering(FliteringEvent event, Emitter<FilteringState> emit) {
    emit(FilteringState(event.filter));
  }
}