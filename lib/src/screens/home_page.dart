import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_bloc.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_event.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_state.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/navigation_bloc/navigation_bloc.dart';
import '../blocs/navigation_bloc/navigation_state.dart';
import '../models/movie.dart';
import '../widgets/coming_soon_widget.dart';
import '../widgets/now_playing_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DataLoadBloc dataLoadBloc;

  @override
  void initState() {
    dataLoadBloc = context.read<DataLoadBloc>();
    dataLoadBloc.add(SetLanguageEvent(context.read<ConfigurationBloc>().state.languageCode));
    dataLoadBloc.add(const StartLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataLoadBloc, DataLoadState>(builder: (context, state) {
      if (state is DataLoadSuccessState) {
        return Builder(builder: (context) {
          List<Movie> moviesTmp = state.movies;
          if (context.read<ConfigurationBloc>().state.isFiltering) {
            moviesTmp =
                moviesTmp.where((movie) => (movie.rating ?? 0) > 3.0).toList();
          }
          return content(
              userId: widget.userId,
              movies: moviesTmp,
              context: context,
              state: state);
        });
      } else if (state is DataLoadInitialState ||
          state is DataLoadInProgressState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DataLoadFailureState) {
        return Center(child: Text(state.error));
      } else {
        return const Center(child: Text('Unknown state'));
      }
    });
  }

  Widget content(
      {required String userId,
      required List<Movie> movies,
      required BuildContext context,
      required DataLoadSuccessState state}) {
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
                Expanded(child: welcomeMessage(userId: userId)),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/configuration').then((_) {
                      if (context
                              .read<ConfigurationBloc>()
                              .state
                              .languageCode !=
                          state.languageCode) {
                        dataLoadBloc.add(SetLanguageEvent(context
                            .read<ConfigurationBloc>()
                            .state
                            .languageCode));

                        dataLoadBloc.add(const StartLoadingEvent());
                      } else {
                        setState(() {});
                      }
                    });
                  },
                  child: Image.asset('assets/icon_configuration.png',
                      width: 32, height: 32),
                ),
              ]),
              const SizedBox(height: 16),
              searchWidget(),
              const SizedBox(height: 16),
              subTiltle(
                  title: AppLocalizations.of(context)!.nowplaying,
                  action: () {
                    context.read<NavigationBloc>().add(
                        MoviePageWithTabEvent(2, TabMovieStateEnum.nowPlaying));
                  }),
              const SizedBox(height: 8),
              NowPlayingWidget(
                  movies: movies
                      .where((movie) => movie.isPlaying ?? false)
                      .toList()),
              const SizedBox(height: 8),
              subTiltle(
                  title: AppLocalizations.of(context)!.comingsoon,
                  action: () {
                    context.read<NavigationBloc>().add(
                        MoviePageWithTabEvent(2, TabMovieStateEnum.comingSoon));
                  }),
              ComingSoonWidget(
                  movies: movies
                      .where((movie) => movie.isComing ?? false)
                      .toList()),
            ],
          ),
        ),
      )),
    );
  }

  Widget searchWidget() {
    return SearchBar(
      hintText: AppLocalizations.of(context)!.search,
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

  Widget subTiltle({required String title, required Function action}) {
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
            Text(AppLocalizations.of(context)!.viewall,
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

  Widget welcomeMessage({required String userId}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.hi(userId),
            style: Theme.of(context).textTheme.bodySmall),
        Text(
          AppLocalizations.of(context)!.welcomeback,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
