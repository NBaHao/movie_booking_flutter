enum NavigationStateEnum {
  homePage,
  ticketPage,
  moviePage,
  profilePage,
}

class NavigationState {
  NavigationStateEnum currentPage;
  NavigationState(this.currentPage);
}
