import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizzlingtaste/constants/AppColor.dart';
import 'package:sizzlingtaste/controller.dart';


class OtpScreen extends StatelessWidget {
   OtpScreen({Key? key}) : super(key: key);

   final controlle = Get.put(HomeController());

   TextEditingController textEditingController = TextEditingController();
   RxString currentText = "".obs;
   final formKey = GlobalKey<FormState>();
   bool hasError = false;

   var onTapRecognizer = TapGestureRecognizer();

  StreamController <ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body:GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Phone Number Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: controlle.phoneNoText.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: 50,
                          activeFillColor:
                          hasError ? AppColor.colorPrimary : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 30),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        // backgroundColor: Colors.blue.shade50,
                        // enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        // boxShadows: [
                        //   BoxShadow(
                        //     offset: Offset(0, 1),
                        //     color: Colors.black12,
                        //     blurRadius: 10,
                        //   )
                        // ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          currentText = value.obs;

                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Please fill up all the codes properly" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Didn't receive the code? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: " RESEND",
                            recognizer: onTapRecognizer,
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.value.length != 6 || currentText != "towtow") {
                          errorController.add(ErrorAnimationType.shake); // Triggering error shake animation
                          hasError = true;

                        } else {
                          hasError = false;
                          scaffoldKey.currentState;
                          Get.snackbar("Congratulations", "");
                        }
                      },
                      child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     ElevatedButton(
                //       child: Text("Clear Code"),
                //       onPressed: () {
                //         textEditingController.clear();
                //       },
                //     ),
                //     ElevatedButton(
                //       child: Text("Set Text"),
                //       onPressed: () {
                //         textEditingController.text = "123456";
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      );

  }
}
