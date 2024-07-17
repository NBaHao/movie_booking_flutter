import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationEvent {
  final int index;
  NavigationEvent(this.index);
}

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0) {
    on<NavigationEvent>((event, emit) {
      emit(event.index);
    });
  }
}