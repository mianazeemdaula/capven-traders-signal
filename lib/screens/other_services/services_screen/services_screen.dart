import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/models/otoplan_model.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/screens/other_services/contact_submitted/contact_submitted_screen.dart';
import 'components/services_carosel_slider.dart';

class ServicesScreen extends StatelessWidget {
  final List<OtherSerice> _list = [
    OtherSerice(
      id: 'premium_service',
      title: "Premium",
      description: "Special one on one call",
      price: "\$299",
      features: [
        '1 Hour one on one call',
        'Questions about Trading',
        'Personal Advice',
        'Strategy Breakdown',
        'Phychological Advice',
      ],
    ),
    // OtherSerice(
    //   id: 'advance_service',
    //   title: "Advance",
    //   description: "Special one on one call",
    //   price: "\$399",
    //   features: [
    //     '2 Hours one on one call',
    //     'Questions about Trading',
    //     'Personal Advice',
    //     'Strategy Breakdown',
    //     'Phychological Advice',
    //   ],
    // )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTHER SERVICES"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: kServiceDb
            .where('user', isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .where('isServed', isEqualTo: false)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (snapshot.data.docs.length == 0)
            return ServiceCarouselSlider(list: _list);
          return ContactSubmmittedScreen(docs: snapshot.data.docs);
        },
      ),
    );
  }
}
