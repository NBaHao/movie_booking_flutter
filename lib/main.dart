import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/DataLoadBloc.dart';
import 'package:movie_booking/src/blocs/FilteringBloc.dart';
import 'src/MyApp.dart';
import 'src/blocs/NavigationBloc.dart';


void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
      BlocProvider<FilteringBloc>(create: (context) => FilteringBloc()),
      BlocProvider<DataLoadBloc>(create: (context) => DataLoadBloc())
      ], 
    child: const MyApp()
    ),
  );
}