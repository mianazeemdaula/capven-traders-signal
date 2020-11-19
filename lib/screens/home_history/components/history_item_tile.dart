import 'package:flutter/material.dart';

class HistoryItemTile extends StatelessWidget {
  final String title;
  final String trailing;
  final Color color;

  const HistoryItemTile({Key key, this.title, this.trailing, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$title"),
      trailing: FittedBox(
        child: Row(
          children: [
            Text(
              "$trailing pips",
              style: TextStyle(color: color, fontSize: 18),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
