import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradiing_app/bloc/remote_config_service.dart';
import 'package:tradiing_app/screens/other_services/service_middleware.dart';
import 'package:tradiing_app/screens/webview/webview_scree.dart';

import 'components/grid_tile.dart';

class HomeFirstStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoreGridTile(
                title: "Welcome",
                onTap: () {
                  Get.to(WebViewScreen(
                    url: RemotConf().getUrl('welcome_page'),
                  ));
                },
              ),
              SizedBox(width: 20),
              MoreGridTile(
                title: "How the app work",
                onTap: () {
                  Get.to(WebViewScreen(
                    url: RemotConf().getUrl('how_app_work'),
                  ));
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoreGridTile(
                title: "Risk Managment",
                onTap: () {
                  Get.to(WebViewScreen(
                    url: RemotConf().getUrl('riks_management'),
                  ));
                },
              ),
              SizedBox(width: 20),
              MoreGridTile(
                title: "How to trade",
                onTap: () {
                  Get.to(WebViewScreen(
                    url: RemotConf().getUrl('how_to_trade'),
                  ));
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          MoreGridTile(
            title: "Other Services",
            onTap: () => Get.to(ServiceMiddleware()),
          )
        ],
      ),
    );
  }
}
