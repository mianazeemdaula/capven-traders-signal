import 'package:flutter/material.dart';

enum EmptyMessageType { EmptyTrade }

class EmptyMessage extends StatelessWidget {
  final EmptyMessageType messageType;

  const EmptyMessage({Key key, this.messageType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          message(),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  String message() {
    switch (messageType) {
      case EmptyMessageType.EmptyTrade:
        return "NO ACTIVE TRADE NOW.\nWE ARE PREPARING NEW TRADE";
        break;
      default:
        return "NO RESULTS";
    }
  }
}
