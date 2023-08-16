import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Icon(Icons.more_vert)
      ]),
    );
  }
}
