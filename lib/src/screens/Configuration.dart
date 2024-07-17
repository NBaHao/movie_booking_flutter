import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/FilteringBloc.dart';

class Configuration extends StatelessWidget {
  const Configuration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteringBloc, bool>(
      builder: (context, isFiltering) {
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
              value: isFiltering,
              onChanged: (value) {
                BlocProvider.of<FilteringBloc>(context).add(FilteringEvent(value));
              },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}