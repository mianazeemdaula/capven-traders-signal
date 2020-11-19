import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/screens/other_services/service_form/service_form.dart';
import 'package:tradiing_app/screens/other_services/services_screen/services_screen.dart';

class ServiceMiddleware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<IAPService, ServiceStatus>(
      builder: (context, value, child) {
        switch (value) {
          case ServiceStatus.NotPurchased:
            return ServicesScreen();
            break;
          default:
            return ServiceFormScreen();
        }
      },
      selector: (context, value) => value.serviceStatus,
    );
  }
}
