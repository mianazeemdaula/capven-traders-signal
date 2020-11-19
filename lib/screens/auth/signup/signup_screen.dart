import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:tradiing_app/bloc/auth_service.dart';
import 'package:tradiing_app/components/default_button.dart';
import 'package:tradiing_app/helpers/constants.dart';
import 'package:tradiing_app/helpers/size_config.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // UI Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall:
            context.select<UserRepository, bool>((value) => value.isUiBusy),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getUiWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Signup",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getUiWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Fill the form to register with CapvenTraders",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getUiWidth(30)),
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          attribute: 'name',
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Please enter name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(3),
                          ],
                        ),
                        SizedBox(height: getUiHeight(15)),
                        FormBuilderTextField(
                          attribute: 'email',
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Please enter email address",
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
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Please enter password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ],
                        ),
                        SizedBox(height: getUiHeight(10)),
                        // FormBuilderTextField(
                        //   attribute: 'contact',
                        //   decoration: InputDecoration(
                        //     labelText: "Contact",
                        //     hintText: "signup_contact_place_holder".tr,
                        //     floatingLabelBehavior: FloatingLabelBehavior.always,
                        //   ),
                        //   validators: [
                        //     FormBuilderValidators.required(),
                        //     FormBuilderValidators.minLength(6),
                        //   ],
                        // ),
                        SizedBox(height: getUiHeight(20)),
                        DefaultButton(
                          text: "Continue",
                          press: () async {
                            if (_formKey.currentState.saveAndValidate()) {
                              try {
                                context.read<UserRepository>().signUp(
                                      _formKey.currentState.value,
                                      context,
                                    );
                              } catch (e) {
                                var snackbar = SnackBar(
                                  content: Text("$e"),
                                );
                                _scaffoldKey.currentState
                                    .showSnackBar(snackbar);
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
