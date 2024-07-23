import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_bloc.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_event.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_state.dart';
import 'package:movie_booking/src/blocs/filtering_bloc/filtering_state.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_event.dart';

import '../blocs/filtering_bloc/filtering_bloc.dart';
import '../blocs/navigation_bloc/navigation_bloc.dart';
import '../blocs/navigation_bloc/navigation_state.dart';
import '../models/movie.dart';
import '../widgets/coming_soon.dart';
import '../widgets/now_playing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DataLoadBloc>().add(const StartLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataLoadBloc, DataLoadState>(builder: (context, state) {
      if (state is DataLoadSuccess) {
        return BlocBuilder<FilteringBloc, FilteringState>(
            builder: (context, isFiltering) {
          List<Movie> moviesTmp = state.movies;
          if (BlocProvider.of<FilteringBloc>(context).state.isFiltering) {
            moviesTmp =
                moviesTmp.where((movie) => movie.rating! > 3.0).toList();
          }
          return content(
              userId: widget.userId, movies: moviesTmp, context: context);
        });
      } else if (state is DataLoadInitial || state is DataLoadInProgress) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DataLoadFailure) {
        return Center(child: Text(state.error));
      } else {
        return const Center(child: Text('Unknown state'));
      }
    });
  }
}

Widget content(
    {required String userId,
    required List<Movie> movies,
    required BuildContext context}) {
  return SafeArea(
    top: true,
    child: Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: WelcomeMessage(userId: userId)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/configuration');
                },
                child: Image.asset('assets/icon_configuration.png',
                    width: 32, height: 32),
              ),
            ]),
            const SizedBox(height: 16),
            const SearchWidget(),
            const SizedBox(height: 16),
            SubTiltle(
                title: 'Now Playing',
                action: () {
                  context.read<NavigationBloc>().add(
                      MoviePageWithTabEvent(2, TabMovieStateEnum.nowPlaying));
                }),
            const SizedBox(height: 8),
            NowPlaying(
                movies: movies.where((movie) => movie.isPlaying!).toList()),
            const SizedBox(height: 8),
            SubTiltle(
                title: 'Coming Soon',
                action: () {
                  context.read<NavigationBloc>().add(
                      MoviePageWithTabEvent(2, TabMovieStateEnum.comingSoon));
                }),
            ComingSoon(
                movies: movies.where((movie) => movie.isComing!).toList()),
          ],
        ),
      ),
    )),
  );
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
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
      onTap: () {
        Navigator.pushNamed(context, '/searching',
                arguments: context.read<DataLoadBloc>().state.movies)
            .then((_) =>
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus());
      },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onChanged: (value) => Navigator.pushNamed(context, '/searching',
          arguments: context.read<DataLoadBloc>().state.movies),
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
