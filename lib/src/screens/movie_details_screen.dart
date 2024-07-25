import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking/src/widgets/celebs_widget.dart';
import 'package:movie_booking/src/widgets/movie_info_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: mainContent(context),
            ),
            backBtn(context),
            bookingBtn(context),
          ],
        ),
      ),
    );
  }

  Positioned backBtn(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 0, 0, 0),
          borderRadius: BorderRadius.circular(14),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(215, 255, 255, 255),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Column mainContent(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Image(
            image: NetworkImage(movie.posterUrl ??
                "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 120, 16, 0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(28, 28, 28, 1),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      movie.name ?? "null",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                      strutStyle: const StrutStyle(
                        forceStrutHeight: true,
                        height: 1.8,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      movie.releaseDate != null
                          ? "${(movie.duration ?? 0) ~/ 60}h${(movie.duration ?? 0) % 60}m • ${DateFormat('dd.MM.yyyy').format(movie.releaseDate!)}"
                          : "${(movie.duration ?? 0) ~/ 60}h${(movie.duration ?? 0) % 60}m",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromRGBO(191, 191, 191, 1),
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Text(AppLocalizations.of(context)!.review,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(242, 242, 242, 1),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(movie.rating?.toStringAsFixed(2) ?? "null",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(242, 242, 242, 1),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text(
                          AppLocalizations.of(context)!
                              .numOfReivew(movie.totalVotes ?? 0),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          )),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                            rating: movie.rating ?? 0,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            itemSize: 32),
                        OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow_rounded,
                                color: Color.fromRGBO(191, 191, 191, 1)),
                            label: Text(AppLocalizations.of(context)!.watchTrailer,
                                style: const TextStyle(
                                    color: Color.fromRGBO(191, 191, 191, 1))),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color.fromRGBO(191, 191, 191, 1)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            )),
                      ],
                    ),
                  ),
                ],
              )),
        ]),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieInfoWidget(
                  title: AppLocalizations.of(context)!.movieGenre, value: movie.genres?.join(", ") ?? ""),
              const SizedBox(height: 8),
              MovieInfoWidget(
                  title: AppLocalizations.of(context)!.censorship, value: movie.censorRating ?? ""),
              const SizedBox(height: 8),
              MovieInfoWidget(title: AppLocalizations.of(context)!.language, value: movie.languages ?? ""),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.storyLine,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 12),
              ReadMoreText(movie.storyline ?? "null",
                  textAlign: TextAlign.justify,
                  trimLines: 3,
                  colorClickableText: Theme.of(context).colorScheme.primary,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: AppLocalizations.of(context)!.seeMore,
                  trimExpandedText: AppLocalizations.of(context)!.seeLess,
                  lessStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                  moreStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: const Color.fromRGBO(246, 246, 246, 1))),
              const SizedBox(height: 20),
              CelebsWidget(title: AppLocalizations.of(context)!.director, celebs: movie.directors ?? []),
              const SizedBox(height: 20),
              CelebsWidget(title: AppLocalizations.of(context)!.actor, celebs: movie.actors ?? []),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }

  bookingBtn(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(AppLocalizations.of(context)!.bookingNow,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
