import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';

import 'components/bullet.dart';

class SubscribeScreenOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CAPVEN TRADERS"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "SIGN UP NOW",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 5,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("CANCEL ANY TIME"),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                "ELITE TRADER : PREMIUM",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 20),
              Bullet(title: "Signals"),
              SizedBox(height: 10),
              Bullet(title: "Webinars"),
              SizedBox(height: 10),
              Bullet(title: "24/7 Support"),
              SizedBox(height: 10),
              Bullet(title: "Bonus : Free Course"),
              SizedBox(height: 30),
              Container(
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.green,
                  onPressed: () async {
                    // Route route =
                    //     MaterialPageRoute(builder: (_) => HomeScreen());
                    // Navigator.of(context).push(route);
                    await context.read<IAPService>().purchaseItem(
                          'month_subscription',
                          isConsumable: false,
                        );
                  },
                  child: Text(
                    "Get Access Now (\$99.99/Per Month)",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Cancel anytime",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Already a member?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Click here to login",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.yellow, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
