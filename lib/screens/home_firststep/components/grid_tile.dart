import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/size_config.dart';

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
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(15),
            height: getUiHeight(150),
            child: Center(
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: getUiWidth(20)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
