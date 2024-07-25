import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/configuration_bloc/configuration_bloc.dart';
import 'src/my_app.dart';

void main() {
  runApp(BlocProvider<ConfigurationBloc>(
    create: (context) => ConfigurationBloc(),
    child: const MyApp(),
  ));
}
