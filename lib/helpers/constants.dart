import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kPrimaryColor = Color(0xFF9e44b6);
const Color kSecondaryColor = Color(0xFF6a097d);
const Color kTextColor = Color(0xFFf1d4d4);
const Color kText2Color = Color(0xFFc060a1);

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(0, 0, 0, .1),
  100: Color.fromRGBO(0, 0, 0, .2),
  200: Color.fromRGBO(0, 0, 0, .3),
  300: Color.fromRGBO(0, 0, 0, .4),
  400: Color.fromRGBO(0, 0, 0, .5),
  500: Color.fromRGBO(0, 0, 0, .6),
  600: Color.fromRGBO(0, 0, 0, .7),
  700: Color.fromRGBO(0, 0, 0, .8),
  800: Color.fromRGBO(0, 0, 0, .9),
  900: Color.fromRGBO(0, 0, 0, 1),
};
// Green color code: FF93cd48
MaterialColor kAppColor = MaterialColor(0xFF000000, colorCodes);

CollectionReference kServiceDb =
    FirebaseFirestore.instance.collection('services');
CollectionReference kForexDb = FirebaseFirestore.instance.collection('forex');
CollectionReference kIndicesDb =
    FirebaseFirestore.instance.collection('indices');
CollectionReference kOptionsDb =
    FirebaseFirestore.instance.collection('options');
CollectionReference kMessageDb =
    FirebaseFirestore.instance.collection('messages');

kErrorSnakbar(error) {
  Get.snackbar(
    "Error!",
    "$error",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.5),
  );
}

kSuccessSnakbar(msg) {
  Get.snackbar(
    "Success!",
    "$msg",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.withOpacity(0.5),
  );
}
