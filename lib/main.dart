import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/screens/auth/signin/signin_screen.dart';
import 'bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/screens/home/home_screen.dart';
import 'package:tradiing_app/screens/subscribe/subscribe_screen.dart';
import 'package:tradiing_app/screens/auth/signup/signup_screen.dart';
import 'package:tradiing_app/screens/auth/reset_password/reset_password_screen.dart';
import 'components/splash_screen.dart';
import 'helpers/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Platform.isAndroid) InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRepository.instance()),
        ChangeNotifierProvider<IAPService>(
          create: (_) => IAPService(),
          // lazy: false,
        ),
      ],
      child: GetMaterialApp(
        title: 'Trading Signals',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
            primaryColor: kAppColor,
            brightness: Brightness.dark,
            accentColor: kSecondaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              // color: kSecondaryColor,
            ),
            textTheme: GoogleFonts.overpassTextTheme(
              Theme.of(context).textTheme.copyWith(
                    headline3: TextStyle(color: Colors.white),
                    headline6: TextStyle(color: Colors.white),
                    bodyText1: TextStyle(color: Colors.white),
                    bodyText2: TextStyle(color: Colors.white),
                    button: TextStyle(color: Colors.white),
                    subtitle1: TextStyle(color: Colors.white),
                  ),
            )
            // textTheme: GoogleFonts.latoTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            ),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: AuthMiddleWare(),
        getPages: [
          GetPage(
            name: '/register',
            page: () => SignUpScreen(),
          ),
          GetPage(
            name: '/resetpassword',
            page: () => ResetPasswordScreen(),
          )
        ],
      ),
    );
  }
}

class AuthMiddleWare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Selector<UserRepository, Status>(
        builder: (context, value, child) {
          switch (value) {
            case Status.Uninitialized:
              return Splash();
              break;
            case Status.Unauthenticated:
              return SigninScreen();
            case Status.Authenticating:
              return Splash();
              break;
            case Status.Authenticated:
              return MiddleWareScreen();
              break;
          }
          return Splash();
        },
        selector: (context, value) => value.status);
  }
}

class MiddleWareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Selector<IAPService, PurchaseStatus>(
      builder: (context, value, child) {
        switch (value) {
          case PurchaseStatus.pending:
            return SubscribeScreen();
            break;
          case PurchaseStatus.error:
            return Center(
              child: Text("ERROR IN PURCHASE"),
            );
            break;
          default:
            return HomeScreen();
        }
      },
      selector: (context, value) => value.monthlySubscriptionStatus,
    );
  }
}
