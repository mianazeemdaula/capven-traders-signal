import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomeChatScreen extends StatelessWidget {
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  FormBuilderDropdown(
                    attribute: 'pair',
                    items: [
                      DropdownMenuItem(child: Text("EUR/USD"), value: 1),
                      DropdownMenuItem(child: Text("GPB/USD"), value: 2),
                      DropdownMenuItem(child: Text("AUD/USD"), value: 3),
                      DropdownMenuItem(child: Text("AUD/CAD"), value: 4),
                      DropdownMenuItem(child: Text("AUD/CHF"), value: 5),
                      DropdownMenuItem(child: Text("USD/CAD"), value: 6),
                      DropdownMenuItem(child: Text("USD/JPY"), value: 7),
                      DropdownMenuItem(child: Text("EUR/JPY"), value: 8),
                      DropdownMenuItem(child: Text("GBP/AUD"), value: 9),
                      DropdownMenuItem(child: Text("NZD/USD"), value: 10),
                      DropdownMenuItem(child: Text("EUR/GBP"), value: 11),
                    ],
                    decoration: InputDecoration(hintText: "Please select pair"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderDropdown(
                    attribute: 'signal',
                    items: [
                      DropdownMenuItem(child: Text("Buy at Market"), value: 1),
                      DropdownMenuItem(child: Text("Sell at Market"), value: 2),
                      DropdownMenuItem(child: Text("Buy Limit"), value: 3),
                      DropdownMenuItem(child: Text("Sell Limit"), value: 4),
                      DropdownMenuItem(child: Text("Buy Stop"), value: 5),
                      DropdownMenuItem(child: Text("Sell Stop"), value: 6),
                    ],
                    decoration:
                        InputDecoration(hintText: "Please select signal"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderDropdown(
                    attribute: 'status',
                    items: [
                      DropdownMenuItem(
                          child: Text("Waiting for target"), value: 1),
                      DropdownMenuItem(child: Text("Filled"), value: 2),
                      DropdownMenuItem(child: Text("Waiting"), value: 3),
                      DropdownMenuItem(child: Text("Target 1"), value: 4),
                      DropdownMenuItem(child: Text("Target 2"), value: 5),
                      DropdownMenuItem(child: Text("Stop loss"), value: 6),
                      DropdownMenuItem(child: Text("Expired"), value: 7),
                    ],
                    decoration:
                        InputDecoration(hintText: "Please select status"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'open_price',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration:
                        InputDecoration(hintText: "Please enter open price"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.pattern(
                          r'^(?!0\d|$)\d*(\.\d{1,4})?$',
                          errorText: "only 4 decimal points allowed")
                    ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'profit1',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration:
                        InputDecoration(hintText: "Please enter profit 1"),
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.pattern(
                          r'^(?!0\d|$)\d*(\.\d{1,4})?$',
                          errorText: "only 4 decimal points allowed")
                    ],
                  ),
                  // SizedBox(height: getUiHeight(20)),
                  // FormBuilderTextField(
                  //   attribute: 'profit2',
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   keyboardType:
                  //       TextInputType.numberWithOptions(decimal: true),
                  //   decoration: InputDecoration(
                  //       hintText: "Please enter profit 2"),
                  //   validators: [
                  //     FormBuilderValidators.required(),
                  //     FormBuilderValidators.numeric(),
                  //     FormBuilderValidators.pattern(
                  //         r'^(?!0\d|$)\d*(\.\d{1,4})?$',
                  //         errorText: "only 4 decimal points allowed")
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'stop_loss',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(hintText: "Stop loss"),
                    // validators: [
                    //   FormBuilderValidators.required(),
                    //   FormBuilderValidators.numeric(),
                    //   FormBuilderValidators.pattern(
                    //       r'^(?!0\d|$)\d*(\.\d{1,4})?$',
                    //       errorText: "only 4 decimal points allowed")
                    // ],
                  ),
                  // SizedBox(height: getUiHeight(20)),
                  // FormBuilderTextField(
                  //   attribute: 'close_price',
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   keyboardType:
                  //       TextInputType.numberWithOptions(decimal: true),
                  //   decoration: InputDecoration(
                  //       hintText: "Please enter close price"),
                  //   validators: [
                  //     FormBuilderValidators.required(),
                  //     FormBuilderValidators.numeric(),
                  //     FormBuilderValidators.pattern(
                  //         r'^(?!0\d|$)\d*(\.\d{1,4})?$',
                  //         errorText: "only 4 decimal points allowed")
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
