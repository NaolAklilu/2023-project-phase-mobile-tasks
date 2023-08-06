import 'package:flutter/material.dart';

class ItemDetailContainer extends StatelessWidget {
  const ItemDetailContainer(this.title, this.description, this.containerSize,
      {super.key});

  final String title;
  final String description;
  final double containerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Container(
            width: 400,
            height: containerSize,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
