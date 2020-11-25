import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class ItemCard extends StatelessWidget {
  final String pair;
  final String date;
  final String condition;
  final IconData icon;
  final Color color;
  const ItemCard(
      {Key key, this.pair, this.date, this.condition, this.icon, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    condition.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: getUiHeight(10)),
                  Text(
                    pair.toUpperCase(),
                    // "${MediaQuery.of(context).platformBrightness}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(date.substring(0, 10)),
                  SizedBox(height: getUiHeight(10)),
                  Icon(
                    icon,
                    color: color,
                    size: getUiHeight(35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
