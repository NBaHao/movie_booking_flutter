import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_bloc.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_state.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/data_load_bloc/data_load_event.dart';
import '../blocs/navigation_bloc/navigation_event.dart';
import '../blocs/navigation_bloc/navigation_state.dart';
import '../models/movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key, required this.firstTab});

  final TabMovieStateEnum firstTab;

  @override
  State<MoviesScreen> createState() => _MoviesState();
}

class _MoviesState extends State<MoviesScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(
      length: 2, vsync: this, initialIndex: widget.firstTab.index);

  @override
  void initState() {
    // context.read<DataLoadBloc>().add(const StartLoadingEvent());
    // print(context.read<DataLoadBloc>().state);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DataLoadBloc, DataLoadState>(
        builder: (context, state) {
          print(state);
          List<Movie> movies = state.movies;
          if (state is DataLoadSuccessState) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(28, 28, 28, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TabBar(
                    labelPadding: const EdgeInsets.all(0),
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor:
                        const Color.fromRGBO(191, 191, 191, 1),
                    tabs: <Widget>[
                      Tab(
                          child: Row(
                        children: [
                          Expanded(
                              child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.nowplaying,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          )),
                        ],
                      )),
                      Tab(
                          child: Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.comingsoon,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ))),
                        ],
                      )),
                    ],
                    onTap: (index) {
                      context.read<NavigationBloc>().add(MoviePageWithTabEvent(
                          2,
                          index == 0
                              ? TabMovieStateEnum.nowPlaying
                              : TabMovieStateEnum.comingSoon));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BlocBuilder<NavigationBloc, NavigationState>(
                      builder: (context, state) {
                        List<Movie> moviesTmp = movies;
                        if (state is NavigationMoviePageState) {
                          if (state.currentMoviePage ==
                              TabMovieStateEnum.nowPlaying) {
                            moviesTmp = movies
                                .where((movie) => movie.isPlaying ?? false)
                                .toList();
                          } else {
                            moviesTmp = movies
                                .where((movie) => movie.isComing ?? false)
                                .toList();
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 0.6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/movie_details',
                                          arguments: moviesTmp[index]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Image.network(
                                            moviesTmp[index].posterUrl ??
                                                "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AutoScrollText(
                                      moviesTmp[index].name ?? 'null',
                                      velocity: const Velocity(
                                          pixelsPerSecond: Offset(40, 0)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 18,
                                          ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.video_camera_back_outlined,
                                          color:
                                              Color.fromRGBO(242, 242, 242, 1),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            moviesTmp[index]
                                                .genres!
                                                .join(", ")
                                                .trim(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today_outlined,
                                          color:
                                              Color.fromRGBO(242, 242, 242, 1),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          moviesTmp[index].releaseDate != null
                                              ? DateFormat('dd.MM.yyyy').format(
                                                  moviesTmp[index].releaseDate!)
                                              : "null",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: moviesTmp.length,
                          );
                        }
                        return const Text('!!!!!!');
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
