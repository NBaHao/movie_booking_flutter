import 'package:movie_booking/src/blocs/navigation_bloc/navigation_state.dart';

abstract class NavigationEvent {
  final int index;
  NavigationEvent(this.index);
}

class SwitchNavigationEvent extends NavigationEvent {
  SwitchNavigationEvent(super.index);
}

class MoviePageWithTabEvent extends NavigationEvent {
  final TabMovieStateEnum tab;
  MoviePageWithTabEvent(super.index, this.tab);
}