import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/DataLoadBloc.dart';

import '../blocs/FilteringBloc.dart';
import '../models/movie.dart';
import '../widgets/ComingSoon.dart';
import '../widgets/NowPlaying.dart';
import 'Configuration.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataLoadBloc, List<Movie>>(builder: (context, movies) {
      if (movies.isEmpty) {
        BlocProvider.of<DataLoadBloc>(context).add(const DataLoadEvent());
        return const Center(child: CircularProgressIndicator());
      } else {
        return BlocBuilder<FilteringBloc, bool>(builder: (context, isFiltering) {
          List<Movie> _movies = movies;
          if (BlocProvider.of<FilteringBloc>(context).state) {
            _movies = _movies.where((movie) => movie.rating! > 3.0).toList();
          }
          return Content(userId: userId, movies: _movies, context: context);
        });
      }
    });
  }
}

Widget Content(
    {required String userId,
    required List<Movie> movies,
    required BuildContext context}) {
  return Scaffold(
    body: SafeArea(
      top: true,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                WelcomeMessage(userId: userId),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Configuration()));
                  },
                  child: Image.asset('assets/icon_configuration.png',
                      width: 32, height: 32),
                ),
              ]),
              const SizedBox(height: 16),
              const Search(),
              const SizedBox(height: 16),
              SubTiltle(title: 'Now Playing', action: () {}),
              const SizedBox(height: 8),
              NowPlaying(
                  movies: movies.where((movie) => movie.isPlaying!).toList()),
              const SizedBox(height: 8),
              SubTiltle(title: 'Coming Soon', action: () {}),
              ComingSoon(
                  movies: movies.where((movie) => movie.isComing!).toList()),
            ],
          ),
        ),
      )),
    ),
  );
}

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search',
      backgroundColor:
          const WidgetStatePropertyAll<Color>(Color.fromRGBO(28, 28, 28, 1)),
      hintStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
          color: Color.fromRGBO(140, 140, 140, 1),
          fontSize: 14,
          fontWeight: FontWeight.w200)),
      textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(
          color: Color.fromRGBO(242, 242, 242, 1),
          fontSize: 14,
          fontWeight: FontWeight.w200)),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      leading:
          const Icon(Icons.search, color: Color.fromRGBO(242, 242, 242, 1)),
    );
  }
}

class SubTiltle extends StatelessWidget {
  const SubTiltle({super.key, required this.title, required this.action});

  final String title;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: () => action(),
          child: Row(children: [
            Text('View All',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: const Color.fromRGBO(252, 196, 52, 1))),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary, size: 16),
            )
          ]),
        )
      ],
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi, $userId', style: Theme.of(context).textTheme.bodySmall),
        Text(
          'Welcome Back',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
