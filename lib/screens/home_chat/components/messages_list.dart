import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/models/message_model.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;

  const MessageList({Key key, this.messages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Bubble(
          color: Colors.black,
          margin: BubbleEdges.only(top: 30, right: 50, bottom: 5),
          alignment: Alignment.topLeft,
          nipWidth: 8,
          nipHeight: 24,
          nip: BubbleNip.leftTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messages[index].msg,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                "${messages[index].date}",
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
