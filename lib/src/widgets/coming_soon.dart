import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/movie.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key, required this.movies});
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 160),
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 160,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.network(movies[index].posterUrl!,
                          fit: BoxFit.cover, height: 200, width: 130),
                    )),
                const SizedBox(height: 4),
                AutoScrollText(movies[index].name!,
                    velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.video_camera_back_outlined,
                        color: Color.fromRGBO(242, 242, 242, 1), size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(movies[index].genres!.join(", ").trim(),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: Color.fromRGBO(242, 242, 242, 1), size: 16),
                    const SizedBox(width: 4),
                    Text(
                        DateFormat('dd.MM.yyyy')
                            .format(movies[index].releaseDate!),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
