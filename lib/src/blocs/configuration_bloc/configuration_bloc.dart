import 'package:flutter_bloc/flutter_bloc.dart';

import 'configuration_event.dart';
import 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc()
      : super(ConfigurationState(isFiltering: false, languageCode: "en")) {
    on<FliteringEvent>(_setFiltering);
    on<ChangeLanguageEvent>(_setLanguage);
  }

  void _setLanguage(
      ChangeLanguageEvent event, Emitter<ConfigurationState> emit) {
    emit(ConfigurationState(
        isFiltering: state.isFiltering, languageCode: event.languageCode));
  }

  void _setFiltering(FliteringEvent event, Emitter<ConfigurationState> emit) {
    emit(ConfigurationState(
        isFiltering: event.filter, languageCode: state.languageCode));
  }
}
