import 'package:flutter/material.dart';
import 'package:tradiing_app/screens/home_more/components/grid_tile.dart';

class HomeMoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoreGridTile(
                title: "Welcome",
                onTap: () {},
              ),
              SizedBox(width: 20),
              MoreGridTile(
                title: "How the app work",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoreGridTile(
                title: "Risk Managment",
                onTap: () {},
              ),
              SizedBox(width: 20),
              MoreGridTile(
                title: "How to trade",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 20),
          MoreGridTile(
            title: "Other Services",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
