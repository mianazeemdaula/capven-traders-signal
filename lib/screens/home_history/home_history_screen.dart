import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tradiing_app/screens/home_history/components/history_item_tile.dart';

import 'components/history_type.dart';

class HomeHistoryScreen extends StatefulWidget {
  @override
  _HomeHistoryScreenState createState() => _HomeHistoryScreenState();
}

class _HomeHistoryScreenState extends State<HomeHistoryScreen> {
  var rng = new Random();
  int _forexStock = 0;
  var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: HistoryType(
                  text: "Forex",
                  isSelected: _forexStock == 1,
                  onTap: () {
                    setState(() {
                      _forexStock = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: HistoryType(
                  text: "Indices",
                  isSelected: _forexStock == 0,
                  onTap: () {
                    setState(() {
                      _forexStock = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return HistoryItemTile(
                title: "${months[index]} 2020",
                trailing: rng.nextInt(100).toString(),
                color: Colors.green,
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
        )
      ],
    );
  }
}
