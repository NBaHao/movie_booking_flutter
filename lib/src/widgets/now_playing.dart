import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/movie.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key, required this.movies});
  final List<Movie> movies;

  @override
  State<StatefulWidget> createState() {
    return _NowPlayingState();
  }
}

class _NowPlayingState extends State<NowPlaying> {
  int _currentMovie = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return OverflowBox(
                  maxHeight: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/movie_details',
                          arguments: movie);
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 160,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Image.network(movie.posterUrl!,
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            "${movie.duration! ~/ 60}h${movie.duration! % 60}m • ${movie.genres!.join(', ').trim()}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star,
                                color: Theme.of(context).colorScheme.primary,
                                size: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(movie.rating!.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800)),
                                Text(
                                    ' (${NumberFormat("###,###", "tr_TR").format(movie.totalVotes)})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 11)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 1.1,
            viewportFraction: 0.5,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) => {
              setState(() {
                _currentMovie = index;
              })
            },
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _currentMovie,
          count: widget.movies.length,
          effect: ExpandingDotsEffect(
            expansionFactor: 2,
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: const Color.fromARGB(201, 86, 86, 86),
            dotHeight: 6,
            dotWidth: 10,
            spacing: 5,
          ),
        ),
      ],
    );
  }
}
