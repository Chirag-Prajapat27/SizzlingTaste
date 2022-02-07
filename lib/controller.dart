import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  List <SideMenuDataModel> sideMenuData = <SideMenuDataModel> [].obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final teMobileNo = TextEditingController();
  RxString phoneNoText = "".obs;


  void onInit(){
  super.onInit();
  teMobileNo.addListener(() {
    phoneNoText.value = teMobileNo.text;
  });
  staticData();
  }


 List <SideMenuDataModel> staticData(){
    sideMenuData.add(SideMenuDataModel("Home", Icons.home_filled));
    sideMenuData.add(SideMenuDataModel("Categories", Icons.category));
    sideMenuData.add(SideMenuDataModel("Favourites", Icons.favorite_border_rounded));
    sideMenuData.add(SideMenuDataModel("Order History", Icons.history));
    sideMenuData.add(SideMenuDataModel("Share", Icons.share));
    sideMenuData.add(SideMenuDataModel("LogOut", Icons.logout));
     return sideMenuData;
  }

  verifyPhoneNo(String $mobileNo,){
    auth.verifyPhoneNumber(
      phoneNumber: '+91 ' + $mobileNo,
      timeout: Duration(seconds: 60),

      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },

      codeSent: (String verificationId, int? resendToken) {
        String smsCode = " ";
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        auth.signInWithPhoneNumber($mobileNo);
      },

      verificationFailed: (FirebaseAuthException error) {
        if(error.code == ''){
          print("Phone NUmber is incorrect");
        }
      },

      codeAutoRetrievalTimeout: (String verificationId) {

      },

    );
  }


}