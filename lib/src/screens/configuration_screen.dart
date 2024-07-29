import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_booking/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:movie_booking/src/blocs/configuration_bloc/configuration_event.dart';
import 'package:movie_booking/src/blocs/configuration_bloc/configuration_state.dart';
import 'package:movie_booking/src/localizations.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<ConfigurationScreen> {
  late AppLocalizations _localizations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
        builder: (context, state) {
          _localizations = localizations(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(_localizations.configuration),
          centerTitle: true,
          actionsIconTheme: const IconThemeData(),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_localizations.filter),
                    Switch(
                      value: state.isFiltering,
                      onChanged: (value) {
                        context
                            .read<ConfigurationBloc>()
                            .add(FliteringEvent(value));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_localizations.language),
                    DropdownMenu(
                      width: 150,
                      initialSelection: state.languageCode,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          label: _localizations.english,
                          value: 'en',
                        ),
                        DropdownMenuEntry(
                          label: _localizations.vietnamese,
                          value: 'vi',
                        ),
                      ],
                      onSelected: (value) {
                        context
                            .read<ConfigurationBloc>()
                            .add(ChangeLanguageEvent(value ?? 'en'));
                      },
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
