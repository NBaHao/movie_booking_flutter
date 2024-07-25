import 'package:flutter/material.dart';

class MovieInfoWidget extends StatelessWidget {
  const MovieInfoWidget({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text("$title:",
              style: const TextStyle(
                  fontSize: 16, color: Color.fromRGBO(191, 191, 191, 1))),
        ),
        Expanded(
          flex: 2,
          child:
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(242, 242, 242, 1),
                    fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}
