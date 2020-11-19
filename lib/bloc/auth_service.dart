import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradiing_app/models/user_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _fbStore = FirebaseFirestore.instance;
  bool _isUiBusy = false;
  Auth _auth;

  UserRepository.instance() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User get user => _user;
  bool get isUiBusy => _isUiBusy;
  Auth get auth => _auth;

  Future signIn(String email, String password) async {
    try {
      _isUiBusy = true;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      _status = Status.Unauthenticated;
      _isUiBusy = false;
      notifyListeners();
      throw "username or password not match";
    }
  }

  Future signUp(Map<String, dynamic> data, BuildContext context) async {
    try {
      _isUiBusy = true;
      notifyListeners();
      final QuerySnapshot snapshot = await _fbStore
          .collection('users')
          .where('email', isEqualTo: "${data['email']}")
          .get();
      if (snapshot.docs.length == 0) {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: data['email'],
          password: data['password'],
        );
        data['createdAt'] = FieldValue.serverTimestamp();
        data['type'] = 'user';
        data['isSubscribed'] = false;
        if (_firebaseAuth.currentUser != null) {
          await _fbStore
              .collection('users')
              .doc(_firebaseAuth.currentUser.uid)
              .set(data);
        }
      }
      _isUiBusy = false;
      notifyListeners();
    } catch (e) {
      _isUiBusy = false;
      notifyListeners();
    }
  }

  Future<String> uploadFile(File file) async {
    try {
      String _name = DateTime.now().microsecondsSinceEpoch.toString() +
          "." +
          file.path.split('.').last;
      Reference ref = FirebaseStorage.instance.ref().child('$_name');

      UploadTask task = ref.putFile(file);
      await task.whenComplete(() => null);
      return await ref.getDownloadURL();
    } catch (error) {
      Get.snackbar('Error', '$error');
    }
    return null;
  }

  Future updatePassword(String oldPassword, String newPassword) async {
    try {
      _isUiBusy = true;
      notifyListeners();
      await _firebaseAuth.currentUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: _user.email, password: oldPassword),
      );
      await _firebaseAuth.currentUser.updatePassword(newPassword);
      _isUiBusy = false;
      notifyListeners();
    } catch (e) {
      _isUiBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendResetPassword(String email) async {
    try {
      _isUiBusy = true;
      notifyListeners();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      _isUiBusy = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isUiBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future updateFcmToken(String token) async {
    await _fbStore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'fcmToken': token});
  }

  refreshUserData(DocumentSnapshot doc) {
    _auth = Auth.fromSnapshot(doc);
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      var doc = await _fbStore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .get();
      if (doc.exists) {
        _auth = Auth.fromSnapshot(doc);
        // Listen for chaning in user
        print("${doc.reference}");
        doc.reference.snapshots().listen((event) => refreshUserData);
        await _firebaseAuth.currentUser.updateProfile(
          displayName: doc.data()['name'],
        );
      }
      _status = Status.Authenticated;
    }
    _isUiBusy = false;
    notifyListeners();
    Get.back();
  }
}
