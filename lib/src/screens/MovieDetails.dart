import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking/src/widgets/Celebs.dart';
import 'package:movie_booking/src/widgets/MovieInfo.dart';
import 'package:readmore/readmore.dart';

import '../models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: MainContent(context),
            ),
            BackBtn(context),
            BookingBtn(context),
          ],
        ),
      ),
    );
  }

  Positioned BackBtn(BuildContext context) {
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

  Column MainContent(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Image(
            image: NetworkImage(movie.posterUrl!),
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
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(
                      movie.name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      "${movie.duration! ~/ 60}h${movie.duration! % 60}m • ${DateFormat('dd.MM.yyyy').format(movie.releaseDate!)}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromRGBO(191, 191, 191, 1),
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      const Text("Review",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(242, 242, 242, 1),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(movie.rating!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(242, 242, 242, 1),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text(
                          "(${NumberFormat("###,###", "tr_TR").format(movie.totalVotes)} reviews)",
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
                            rating: movie.rating!,
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
                            label: const Text("Watch trailer",
                                style: TextStyle(
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
              MovieInfo(title: "Movie genre", value: movie.genres!.join(", ")),
              const SizedBox(height: 8),
              MovieInfo(title: "Censorshi", value: movie.censorRating!),
              const SizedBox(height: 8),
              MovieInfo(title: "Language", value: movie.languages!),
              const SizedBox(height: 20),
              Text("Story line",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 12),
              ReadMoreText(movie.storyline!,
                  textAlign: TextAlign.justify,
                  trimLines: 3,
                  colorClickableText: Theme.of(context).colorScheme.primary,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "See more",
                  trimExpandedText: " See less",
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
              Celebs(title: "Director", celebs: movie.directors!),
              const SizedBox(height: 20),
              Celebs(title: "Actor", celebs: movie.actors!),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }

  BookingBtn(BuildContext context) {
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
        child: const Text("Booking now",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
