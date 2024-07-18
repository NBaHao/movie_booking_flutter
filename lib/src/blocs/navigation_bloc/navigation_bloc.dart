import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_event.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(NavigationStateEnum.homePage)) {
    on<SwitchNavigationEvent>(_switchNavigation);
  }

  void _switchNavigation(event, emit) {
    switch (event.index) {
      case 0:
        emit(NavigationState(NavigationStateEnum.homePage));
        break;
      case 1:
        emit(NavigationState(NavigationStateEnum.ticketPage));
        break;
      case 2:
        emit(NavigationState(NavigationStateEnum.moviePage));
        break;
      default:
        emit(NavigationState(NavigationStateEnum.profilePage));
    }
  }
}