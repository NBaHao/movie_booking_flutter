import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_event.dart';
import '../blocs/search_bloc/search_state.dart';

class MovieSearchingScreen extends StatefulWidget {
  const MovieSearchingScreen({super.key});

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<MovieSearchingScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<SearchBloc>().add(SearchFetchEvent(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: TextField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  hintStyle: const TextStyle(color: Color.fromARGB(95, 255, 255, 255)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchFetchEvent(query));
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
            ),
            body: state.movies.isNotEmpty
                ? ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/movie_details',
                              arguments: state.movies[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
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
                                  child: Image.network(
                                      state.movies[index].posterUrl ??
                                          'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      state.movies[index].name ?? 'null',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                      strutStyle: const StrutStyle(
                                          forceStrutHeight: true, height: 1.2),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${(state.movies[index].duration ?? 0) ~/ 60}h${(state.movies[index].duration) ?? 0 % 60}m',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      state.movies[index].genres?.join(', ') ??
                                          'null',
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
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No movie found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ));
      },
    );
  }
}
