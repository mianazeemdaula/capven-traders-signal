import 'package:flutter/material.dart';

class HistoryType extends StatelessWidget {
  const HistoryType({Key key, this.text, this.onTap, this.isSelected})
      : super(key: key);

  final String text;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("$text"),
      ),
    );
  }
}
