import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradiing_app/components/Item_card.dart';
import 'package:tradiing_app/components/empty_message.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/library.dart';
import 'package:tradiing_app/helpers/size_config.dart';
import 'package:tradiing_app/models/option_model.dart';

class HomeOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: kOptionsDb.where('status', isEqualTo: 'active').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.docs.length == 0) {
          return EmptyMessage(
            messageType: EmptyMessageType.EmptyTrade,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: snapshot.data.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: getUiWidth(5),
              mainAxisSpacing: getUiWidth(5),
            ),
            itemBuilder: (context, index) {
              var option = Option.fromSnapshot(snapshot.data.docs[index]);
              return ItemCard(
                color: Helper.getOptionColor(option.condition),
                condition: option.condition,
                date: option.date,
                icon: Helper.getOptionIcon(option.condition),
                pair: option.pair,
              );
            },
          ),
        );
      },
    );
  }
}
