import 'package:flutter/material.dart';

class Bullet extends StatelessWidget {
  const Bullet({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 10),
        Text("$title", style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}
