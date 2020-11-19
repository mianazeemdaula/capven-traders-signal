import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getUiHeight(40),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getUiWidth(5)),
        ),
        color: color,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getUiWidth(16),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
