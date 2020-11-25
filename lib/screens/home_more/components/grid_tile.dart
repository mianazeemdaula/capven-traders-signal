import 'package:flutter/material.dart';

class MoreGridTile extends StatelessWidget {
  final String title;
  final Function onTap;

  const MoreGridTile({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5.0,
        shadowColor: Colors.white,
        color: Colors.black,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(35),
            height: 150,
            child: Center(
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
