import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: getUiWidth(250),
          width: getUiHeight(250),
          child: Image.asset(
            "assets/images/logo.jpg",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
