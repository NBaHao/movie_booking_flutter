import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/src/models/movie.dart';

import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_event.dart';
import '../blocs/search_bloc/search_state.dart';

class MovieSearching extends StatefulWidget {
  final List<Movie> movies;
  const MovieSearching({super.key, required this.movies});

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<MovieSearching> {
  final TextEditingController _searchController = TextEditingController();
  final SearchBloc _searchBloc = SearchBloc();

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _searchBloc.add(SearchEventFetch('', widget.movies));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => _searchBloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                autofocus: true,
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  _searchBloc.add(SearchEventFetch(query, widget.movies));
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
            ),
            body: ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 70,
                          height: 85,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Image.network(state.movies[index].posterUrl!,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              state.movies[index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                              strutStyle: const StrutStyle( forceStrutHeight: true, height: 1.2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.movies[index].duration! ~/ 60}h${state.movies[index].duration! % 60}m',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              state.movies[index].genres!.join(', '),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}