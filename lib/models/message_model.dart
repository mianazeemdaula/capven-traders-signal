import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String msg;
  final String date;

  Message({this.id, this.msg, this.date});

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      id: snapshot.id,
      msg: snapshot.data()['msg'],
      date: snapshot.data()['createdAt'].toDate().toString(),
    );
  }
}
