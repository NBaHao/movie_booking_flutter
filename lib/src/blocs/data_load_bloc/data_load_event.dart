abstract class DataLoadEvent {
  const DataLoadEvent();
}

class StartLoadingEvent extends DataLoadEvent {
  const StartLoadingEvent();
}

class SetFilteringEvent extends DataLoadEvent {
  const SetFilteringEvent();
}

class SetLanguageEvent extends DataLoadEvent {
  const SetLanguageEvent(this.languageCode);

  final String languageCode;
}