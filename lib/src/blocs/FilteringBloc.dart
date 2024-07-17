import 'package:flutter_bloc/flutter_bloc.dart';

class FilteringEvent {
  final bool isFiltering;
  FilteringEvent(this.isFiltering);
}

class FilteringBloc extends Bloc<FilteringEvent, bool> {
  FilteringBloc() : super(false) {
    on<FilteringEvent>((event, emit) {
      emit(event.isFiltering);
    });
  }
}