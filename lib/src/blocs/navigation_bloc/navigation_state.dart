enum NavigationStateEnum {
  homePage,
  ticketPage,
  moviePage,
  profilePage,
}

enum TabMovieStateEnum {
  nowPlaying,
  comingSoon
}

abstract class NavigationState {
  NavigationStateEnum currentPage;
  NavigationState(this.currentPage);
}

class NavigationPageState extends NavigationState {
  NavigationPageState(super.currentPage);
}

class NavigationMoviePageState extends NavigationState {
  TabMovieStateEnum currentMoviePage;
  NavigationMoviePageState(super.currentPage, this.currentMoviePage);
}
