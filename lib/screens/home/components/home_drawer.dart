import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/models/user_model.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Selector<UserRepository, Auth>(
        builder: (context, value, child) {
          return Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(value.name),
                accountEmail: Text(value.email ?? ""),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://randomuser.me/api/portraits/men/35.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text("Logout"),
                      trailing: Icon(Icons.exit_to_app),
                      onTap: () {
                        context.read<UserRepository>().signOut();
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
        selector: (context, user) => user.auth,
      ),
    );
  }
}
