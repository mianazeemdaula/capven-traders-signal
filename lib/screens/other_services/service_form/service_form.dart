import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/inapp_subscription_service.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class ServiceFormScreen extends StatefulWidget {
  @override
  _ServiceFormScreenState createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONTACT INFO"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: getUiHeight(25)),
                Text(
                  "Contact Info",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getUiWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter contact information for one on one call",
                  textAlign: TextAlign.center,
                ),
                FormBuilderTextField(
                  attribute: 'skype',
                  decoration: InputDecoration(
                    labelText: "Skype ID",
                    hintText: "Enter skype id please",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ],
                ),
                SizedBox(height: getUiHeight(10)),
                DefaultButton(
                  press: () => submitForm(context),
                  text: "SUBMIT",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context) async {
    try {
      if (_formKey.currentState.saveAndValidate()) {
        setState(() {
          loading = true;
        });
        final ipaService = Provider.of<IAPService>(context, listen: false);
        final auth = Provider.of<UserRepository>(context, listen: false);
        String id = ipaService.serviceStatus == ServiceStatus.AdvanceService
            ? 'advance_service'
            : 'premium_service';
        var details = ipaService.getPurchaseItemFromData('$id');

        if (details != null) {
          await kServiceDb.doc().set({
            'user': auth.user.uid,
            'service_type': id,
            'trans_id': details.purchaseID,
            'trans_date': details.transactionDate,
            'created_at': FieldValue.serverTimestamp(),
            'isServed': false,
            'skype': _formKey.currentState.value['skype']
          });
          await context.read<IAPService>().consumeItem('$id');
          kSuccessSnakbar('Your contact information sumitted.');
          Navigator.pop(context);
        }
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      kErrorSnakbar(e);
    }
  }
}
