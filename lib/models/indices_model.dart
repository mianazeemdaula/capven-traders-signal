import 'package:cloud_firestore/cloud_firestore.dart';

class Indices {
  final String id;
  final String pair;
  final String condition;
  final String status;
  final String signal;
  final String date;

  Indices({
    this.id,
    this.pair,
    this.condition,
    this.status,
    this.signal,
    this.date,
  });

  factory Indices.fromSnapshot(DocumentSnapshot snapshot) {
    return Indices(
      id: snapshot.id,
      pair: snapshot.data()['pair'],
      condition: snapshot.data()['condition'],
      status: snapshot.data()['status'],
      signal: snapshot.data()['signal'],
      date: snapshot.data()['date'].toDate().toString(),
    );
  }
}
