import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final String uid;
  final String name;
  final String email;
  final String type;
  final String createdAt;
  final bool isSubscribed;

  Auth({
    this.uid,
    this.name,
    this.email,
    this.type,
    this.isSubscribed,
    this.createdAt,
  });

  factory Auth.fromSnapshot(DocumentSnapshot snap) {
    return Auth(
      uid: snap.id,
      name: snap.data()['name'],
      email: snap.data()['email'],
      type: snap.data()['type'],
      isSubscribed: snap.data()['isSubscribed'] ?? false,
      createdAt: snap.data()['createdAt'] == null
          ? ""
          : snap.data()['createdAt'].toDate().toString(),
    );
  }

  factory Auth.fromMap(Map<String, dynamic> snap) {
    return Auth(
      uid: snap['id'],
      name: snap['name'],
      email: snap['email'],
      type: snap['type'],
      isSubscribed: snap['isSubscribed'] ?? false,
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'createdAt': this.createdAt,
    };
  }
}
