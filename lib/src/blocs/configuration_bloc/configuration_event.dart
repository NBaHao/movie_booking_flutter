abstract class ConfigurationEvent {}

class FliteringEvent extends ConfigurationEvent {
  final bool filter;

  FliteringEvent(this.filter);
}

class ChangeLanguageEvent extends ConfigurationEvent {
  final String languageCode;

  ChangeLanguageEvent(this.languageCode);
}