import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';
import 'components/bullet.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/models/user_model.dart';
import 'package:tradiing_app/components/default_button.dart';

class SubscribeScreen extends StatelessWidget {
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
                  Text(
                    "Term of Use",
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Privacy Policy",
                  ),
                ],
              ),
              SizedBox(height: getUiHeight(20)),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
