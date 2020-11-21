import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Helper {
  static Color getForexColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Colors.green;
    else if (conitdion == 'SELL') return Colors.red;
    return Colors.orange;
  }

  static IconData getForexIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Icons.arrow_upward;
    else if (conitdion == 'SELL') return Icons.arrow_downward;
    return Icons.date_range;
  }

  static Color getIndicesColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Colors.green;
    else if (conitdion == 'SELL') return Colors.red;
    return Colors.orange;
  }

  static IconData getIndicesIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'BUY')
      return Icons.arrow_upward;
    else if (conitdion == 'SELL') return Icons.arrow_downward;
    return Icons.date_range;
  }

  static Color getOptionColor(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'CALL')
      return Colors.green;
    else if (conitdion == 'PUT') return Colors.red;
    return Colors.orange;
  }

  static IconData getOptionIcon(String conitdion) {
    conitdion = conitdion.trim().toUpperCase();
    if (conitdion == 'CALL')
      return Icons.arrow_upward;
    else if (conitdion == 'PUT') return Icons.arrow_downward;
    return Icons.date_range;
  }

  static Future<bool> topicNotification(
      String title, String body, String type) async {
    final String serverToken =
        'AAAAJnR7y5A:APA91bGDABm4_H-Eo18dSpC3XOhGxsNfgkyRwXKIEevRD48XlTWm8wLEMygc63qhwz3Ph_WT01jDKQBn9uj-gopjcjGUQ11O_HGKKHpUAilJDvTWREpMNUVRUQ02vtIptDk18jkd9dC8';

    var response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'type': '$type',
          },
          'to': '/topics/admin',
        },
      ),
    );
    print("Notification Status : ${response.body}");
    return true;
  }
}
