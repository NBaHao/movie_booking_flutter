import 'package:flutter/material.dart';
import 'package:movie_booking/src/models/movie.dart';

class Celebs extends StatelessWidget {
  const Celebs({super.key, required this.title, required this.celebs});
  final String title;
  final List<Celeb> celebs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, color: Color.fromRGBO(242, 242, 242, 1), fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 84,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: celebs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                constraints: const BoxConstraints(minWidth: 170, maxWidth: 170),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(28, 28, 28, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(celebs[index].imageUrl!)
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        celebs[index].name!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}