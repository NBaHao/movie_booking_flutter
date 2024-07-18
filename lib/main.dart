import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_bloc.dart';
import 'src/my_app.dart';

void main() {
  runApp(
      BlocProvider(create: (context) => FilteringBloc(), child: const MyApp())
  );
}
