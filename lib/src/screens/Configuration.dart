import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_state.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/flitering_event.dart';

class Configuration extends StatelessWidget {
  const Configuration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringBloc, FilteringState>(
        builder: (context, state) {
      return Scaffold(
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
                    BlocProvider.of<FilteringBloc>(context)
                        .add(FliteringEvent(value));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
