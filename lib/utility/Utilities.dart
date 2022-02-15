import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/AppColor.dart';
import '../constants/AppFontWeight.dart';
import '../constants/AppStrings.dart';

class Utilities {

  static showSnackBar(String title, {String? message = 'empty',bool snackbarPositonBottom = true}) {

    Get.snackbar(title, message!,snackPosition: snackbarPositonBottom?SnackPosition.BOTTOM:SnackPosition.TOP);

  }

  static showError(String title, {String? message = 'ERROR MESSAGE',bool snackbarPositonBottom = true}) {

    Get.snackbar(title, message!,snackPosition: snackbarPositonBottom==true ? SnackPosition.BOTTOM : SnackPosition.TOP,
    // borderColor: AppColor.colorError,
    titleText: Text(title, style: TextStyle(color: AppColor.colorError, fontSize: 14)),
    icon: Icon(Icons.error, color: Colors.red, size: 30)
    );
  }

  static showSuccessMessage(String title, {String? message = 'Successfully done',bool snackbarPositonBottom = true}) {

    Get.snackbar(title, message!,snackPosition: snackbarPositonBottom==true ? SnackPosition.BOTTOM : SnackPosition.TOP,
        titleText: Text(title, style: TextStyle(color: AppColor.colorLightBlack, fontSize: 14)),
        icon: Icon(Icons.check_circle, color: Colors.lightGreenAccent, size: 30)
    );

  }

  static launchCall(String number) async {
    var url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('could not launch');
    }
  }

  static launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static bool isMobileNumber(String value) {
    RegExp regex = RegExp(r'^-?[0-9]{10}$');
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  //check validation of email
  static bool validateEmail(String value) {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  //Check Validation of Mobile No.
  static bool validateMobileNo(String value) {
    RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }


  /* get device type
  * @param context
  * */
  static String getDeviceType(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS ? "iOS" : "Android";
  }

  static Future<String> getDeviceToken(BuildContext context) async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      return await deviceInfoPlugin.androidInfo
          .then((deviceInfo) => deviceInfo.androidId.toString());
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      return await deviceInfoPlugin.iosInfo
          .then((ss) => ss.identifierForVendor.toString());
    } else {
      return "";
    }
  }

  static List<String> getSplitSpace(String str) {
    return str.split(" ").toList();
  }

  static Future<bool> isConnectedNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Internet true");
        return true;
      } else {
        print("Internet false");
        return false;
      }
    } on SocketException catch (_) {
      print("Internet false catch");
      return false;
    }
  }

  static TextStyle setTextStyle(double fontSize, FontWeight fontWeight,
      {Color color = Colors.black}) {
    return TextStyle(
        height: 1,
        fontFamily: 'Titillium Web Black',
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  static Widget wrapButton({Function? onTap}) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            onTap!();
          },
          child: Container(
            height: 60.0,
            width: 160,
            padding: EdgeInsets.only(left: 48.0, right: 48.0),
            margin: EdgeInsets.only(top: 16, right: 16.0, bottom: 80.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: AppColor.colorTheme,
            ),
            alignment: Alignment.center,
            child: Text(
              AppStrings.next,
              style: Utilities.setTextStyle(
                  AppFontWeight.subTitleText, AppFontWeight.semiBold,
                  color: AppColor.colorPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
