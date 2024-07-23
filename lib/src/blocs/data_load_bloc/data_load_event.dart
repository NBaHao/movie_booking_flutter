abstract class DataLoadEvent {
  const DataLoadEvent();
}

class StartLoadingEvent extends DataLoadEvent {
  const StartLoadingEvent();
}

class SetFilteringEvent extends DataLoadEvent {
  const SetFilteringEvent();
}