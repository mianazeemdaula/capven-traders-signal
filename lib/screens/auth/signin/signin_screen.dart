import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // UI Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall:
              context.select<UserRepository, bool>((value) => value.isUiBusy),
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: getUiWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: getUiHeight(25)),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getUiWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Login to app using email and password",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        SizedBox(height: getUiHeight(15)),
                        FormBuilderTextField(
                          attribute: 'password',
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Please enter password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ],
                          obscureText: true,
                        ),
                        SizedBox(height: getUiHeight(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/resetpassword');
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/register');
                              },
                              child: Text(
                                "New User?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: getUiHeight(20)),
                        DefaultButton(
                          text: "Continue",
                          press: () async {
                            if (_formKey.currentState.saveAndValidate()) {
                              try {
                                var data = _formKey.currentState.value;
                                await context
                                    .read<UserRepository>()
                                    .signIn(data['email'], data['password']);
                              } catch (e) {
                                Get.snackbar(
                                  "Error!",
                                  "$e",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.5),
                                );
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
}
