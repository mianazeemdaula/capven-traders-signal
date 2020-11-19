import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/models/message_model.dart';
import 'package:tradiing_app/screens/home_chat/components/messages_list.dart';

class HomeChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: StreamBuilder<QuerySnapshot>(
        stream: kMessageDb
            .orderBy('createdAt', descending: true)
            .limit(150)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "NO MESSAGES YET",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            );
          }
          return MessageList(
            messages:
                snapshot.data.docs.map((e) => Message.fromSnapshot(e)).toList(),
          );
        },
      ),
    );
  }
}
