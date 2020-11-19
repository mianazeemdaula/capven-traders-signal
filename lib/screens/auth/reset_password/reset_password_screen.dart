import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // UI Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<UserRepository>(context).isUiBusy,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: getUiWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: getUiHeight(25)),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getUiWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rest your password using email address",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          attribute: 'email',
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Please enter email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ],
                        ),
                        SizedBox(height: getUiHeight(20)),
                        DefaultButton(
                          text: "Reset Password",
                          press: () async {
                            if (_formKey.currentState.saveAndValidate()) {
                              try {
                                bool emailSent = await context
                                    .read<UserRepository>()
                                    .sendResetPassword(
                                        _formKey.currentState.value['email']);
                                if (emailSent) {
                                  kSuccessSnakbar("Reset email sent");
                                } else {
                                  kErrorSnakbar("Email address not found");
                                }
                              } catch (e) {
                                kErrorSnakbar("$e");
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSnakBar(String msg) {
    var snackbar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
