import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    print("onBackground: $message");
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class FCM {
  static get instance => _singleton;
  static final FCM _singleton = FCM._internal();

  FCM._internal();
  factory FCM() {
    return _singleton;
  }

  // Objects and variables
  final FirebaseMessaging _messageing = FirebaseMessaging();
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
    _messageing.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        processNotification(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
        processNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        processNotification(message);
        // _navigateToItemDetail(message);
      },
    );
    _messageing.getToken().then((token) => print(token));
    _messageing.subscribeToTopic('customer');
  }

  processNotification(Map<String, dynamic> msg) async {
    String title, body, type = 'undefined', id;
    if (msg.containsKey('notification')) {
      if (msg['notification'].containsKey('title')) {
        title = msg['notification']['title'];
        body = msg['notification']['body'];
      }
    }
    if (msg.containsKey('data')) {
      if (msg['data'].containsKey('title') && title == null) {
        title = msg['data']['title'];
      }
      if (msg['data'].containsKey('body') && body == null) {
        title = msg['data']['body'];
      }

      if (msg['data'].containsKey('type')) {
        type = msg['data']['type'];
      }
      if (msg['data'].containsKey('id')) {
        id = msg['data']['id'];
      }
    }
    title = title ?? "Title not set";
    body = body ?? "Body not set";
    if (type == 'message') {
      navigatTo("/message");
    } else {
      showNotificationDialog(title, body);
    }
  }

  navigatTo(String page) {
    Navigator.pushNamed(_context, page);
  }

  showNotificationDialog(String title, String body) {
    showDialog(
      context: _context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2.0,
        titlePadding: EdgeInsets.all(0.0),
        title: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
          ),
          child: Text(title),
        ),
        content: Text(body),
        actions: [
          Container(
            child: RaisedButton(
              onPressed: () => Navigator.pop(_context),
              child: Text("OK"),
            ),
          )
        ],
      ),
    );
  }
}
