import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_state.dart';

import '../blocs/filtering_bloc/flitering_event.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key, required this.initFilter});

  final bool initFilter;

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  void initState() {
    context.read().add(FliteringEvent(widget.initFilter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringBloc, FilteringState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (_) async {
            Navigator.pop(context, state.isFiltering);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Configuration'),
              centerTitle: true,
              actionsIconTheme: const IconThemeData(),
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Only show movies with rating above 3.0'),
                    Switch(
                      value: state.isFiltering,
                      onChanged: (value) {
                        context.read().add(FliteringEvent(value));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
