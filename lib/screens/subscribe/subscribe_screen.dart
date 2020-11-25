import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';
import 'components/bullet.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/models/user_model.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/screens/webview/webview_scree.dart';

class SubscribeScreen extends StatelessWidget {
  String _android =
      'Payment will be charged to Google Play Account at confirmation of the purchase. Subscription automatically renews, untill auto renew is turned off at least 24-hours before the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user Account Setting after purchase. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.';
  String _ios =
      'Payment will be charged to iTune Account at confirmation of the purchase. Subscription automatically renews, untill auto renew is turned off at least 24-hours before the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user Account Setting after purchase. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.';

  @override
  Widget build(BuildContext context) {
    final _auth = context.select<UserRepository, Auth>((value) => value.auth);
    return Scaffold(
      appBar: AppBar(
        title: Text("CAPVEN Traders".toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<UserRepository>().signOut();
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: getUiHeight(5)),
              Text(
                "Hi, ${_auth.name}",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getUiWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome to CapvenTrading Signals",
              ),
              SizedBox(height: 20),
              Bullet(title: "Signals"),
              SizedBox(height: 10),
              Bullet(title: "Webinars"),
              SizedBox(height: 10),
              Bullet(title: "24/7 Support"),
              SizedBox(height: 10),
              Bullet(title: "Bonus : Free Course"),
              SizedBox(height: 10),
              Bullet(title: "And many more"),
              Spacer(),
              DefaultButton(
                press: () async {
                  await context.read<IAPService>().purchaseItem(
                        'month_subscription',
                        isConsumable: false,
                      );
                },
                text: "Get Access Now (\$99.99/Per Month)",
              ),
              SizedBox(height: 10),
              Text(
                "Cancel anytime",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(WebViewScreen(
                        url: "https://capven-traders.flycricket.io/terms.html",
                      ));
                    },
                    child: Text(
                      "Term of Use",
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(WebViewScreen(
                        url: "https://capven-traders.flycricket.io/terms.html",
                      ));
                    },
                    child: Text(
                      "Privacy Policy",
                    ),
                  ),
                ],
              ),
              SizedBox(height: getUiHeight(20)),
              Text(
                Platform.isAndroid ? _android : _ios,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
