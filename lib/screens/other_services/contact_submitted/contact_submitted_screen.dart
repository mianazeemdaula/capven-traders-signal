import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactSubmmittedScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  const ContactSubmmittedScreen({Key key, this.docs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView.separated(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "Skype: ${docs[index].data()['skype']}",
            ),
            subtitle: Text(
              "${docs[index].data()['trans_id']}",
            ),
            trailing: Text(
              "${timeago.format(DateTime.parse(docs[index].data()['created_at'].toDate().toString()))}",
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
