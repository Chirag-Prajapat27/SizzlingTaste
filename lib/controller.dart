import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin, CodeAutoFill{

  List <SideMenuDataModel> sideMenuData = <SideMenuDataModel> [].obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final teMobileNo = TextEditingController();
  var teRestroName = TextEditingController();
  var teEmail = TextEditingController();
  var teAddress = TextEditingController();
  var teLandmark = TextEditingController();
  var teCity = TextEditingController();
  var teState = TextEditingController();
  var teCountry = TextEditingController();
  var tePinCode = TextEditingController();
  var teOtpTextController = TextEditingController();

  RxString phoneNoText = "".obs;
  var isUpdate = "".obs;
  var otpCode = "".obs;


  @override
  void onInit(){
  super.onInit();
  teMobileNo.addListener(() {
    phoneNoText.value = teMobileNo.text;
  });
  staticData();
  }

  @override
  void onClose(){
    super.onClose();
    teRestroName.dispose();
    teAddress.dispose();
    tePinCode.dispose();
    teEmail .dispose();
    teCity.dispose();
    teCountry.dispose();
    teLandmark.dispose();
    teState.dispose();

  }

  otpVerify() {
    PhoneAuthCredential credential =PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode)
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

  checkCreateAndUpdateScreen(RxBool isUpdateArg){
    if(isUpdateArg == true ) {
      isUpdate = RxString(AppStrings.updateAccount);
          Get.to(CreateAccountShop());
    } else{
      RxString(AppStrings.createAccount);
      Get.offAll(CreateAccountShop());
    }
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

  @override
  void codeUpdated() {
    otpCode = RxString(code!);
    teOtpTextController.text = code!;
  }


}