import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_event.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationPageState(NavigationStateEnum.homePage)) {
    on<SwitchNavigationEvent>(_switchNavigation);
    on<MoviePageWithTabEvent>(_switchMovieTab);
  }

  void _switchNavigation(event, emit) {
    switch (event.index) {
      case 0:
        emit(NavigationPageState(NavigationStateEnum.homePage));
        break;
      case 1:
        emit(NavigationPageState(NavigationStateEnum.ticketPage));
        break;
      case 2:
        emit(NavigationPageState(NavigationStateEnum.moviePage));
        break;
      default:
        emit(NavigationPageState(NavigationStateEnum.profilePage));
    }
  }

  FutureOr<void> _switchMovieTab(event, emit) {
    emit(NavigationMoviePageState(NavigationStateEnum.moviePage, event.tab));
  }
}