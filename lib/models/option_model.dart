import 'package:cloud_firestore/cloud_firestore.dart';

class Option {
  final String id;
  final String pair;
  final String condition;
  final String status;
  final String signal;
  final String date;

  Option({
    this.id,
    this.pair,
    this.condition,
    this.status,
    this.signal,
    this.date,
  });

  factory Option.fromSnapshot(DocumentSnapshot snapshot) {
    return Option(
      id: snapshot.id,
      pair: snapshot.data()['pair'],
      condition: snapshot.data()['condition'],
      status: snapshot.data()['status'],
      signal: snapshot.data()['signal'],
      date: snapshot.data()['date'].toDate().toString(),
    );
  }
}
