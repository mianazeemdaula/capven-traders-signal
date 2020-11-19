import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/helpers/constants.dart';

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
  Function _pageIndex;

  void init(BuildContext context, Function pageIndex) {
    _context = context;
    _pageIndex = pageIndex;
    _messageing.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        processNotification(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if (message.containsKey('data') &&
            message['data'].containsKey('type')) {
          navigatTo(message['data']['type']);
        } else {
          processNotification(message);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if (message.containsKey('data') &&
            message['data'].containsKey('type')) {
          navigatTo(message['data']['type']);
        } else {
          processNotification(message);
        }
      },
    );
    _messageing.getToken().then((token) => print(token));
    _messageing.subscribeToTopic('client');
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
    if (type == 'forex' ||
        type == 'message' ||
        type == 'indices' ||
        type == 'options') {
      navigatTo(type);
    } else {
      showNotificationDialog(title, body);
    }
  }

  navigatTo(String type) {
    int index = 0;
    switch (type) {
      case 'forex':
        index = 0;
        break;
      case 'indices':
        index = 1;
        break;
      case 'options':
        index = 2;
        break;
      case 'message':
        index = 3;
        break;
      default:
        index = 0;
    }
    _pageIndex(index);
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
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
          ),
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
        content: Text(body),
        actions: [
          Container(
            child: RaisedButton(
              color: kPrimaryColor,
              onPressed: () => Navigator.pop(_context),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
