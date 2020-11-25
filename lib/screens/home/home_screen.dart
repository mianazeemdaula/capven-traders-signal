import 'package:flutter/material.dart';
import 'package:tradiing_app/bloc/fcm_services.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/screens/home/components/home_drawer.dart';
import 'package:tradiing_app/screens/home_chat/home_chat_screen.dart';
import 'package:tradiing_app/screens/home_firststep/home_firststep_screen.dart';
import 'package:tradiing_app/screens/home_forex/home_forex_screen.dart';
import 'package:tradiing_app/screens/home_indices/home_indices_screen.dart';
import 'package:tradiing_app/screens/home_options/home_options_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FCM().init(context, changePageIndex);
  }

  changePageIndex(int i) {
    setState(() {
      _index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text("CAPVEN TRADERS"),
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://randomuser.me/api/portraits/men/35.jpg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.yellow,
          )
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          HomeForexScreen(),
          HomeIndicesScreen(),
          HomeOptionsScreen(),
          HomeChatScreen(),
          HomeFirstStepScreen()
          // HomeFirstStepScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        onTap: changePageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: "Forex",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Indices",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Options",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "CapvenRoom",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "Learn More",
          ),
        ],
      ),
    );
  }
}
