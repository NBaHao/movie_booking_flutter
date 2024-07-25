abstract class SearchEvent {}

class SearchFetchEvent extends SearchEvent {
  final String query;
  SearchFetchEvent(this.query);
}

class SearchInitialEvent extends SearchEvent {}