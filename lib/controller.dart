import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/UI/OtpScreen.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';
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
  var verificationID = "".obs;


  @override
  void onInit(){
  super.onInit();
  teOtpTextController.addListener(() {
    otpCode = RxString(teOtpTextController.text);
  });
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

  otpVerify() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value, smsCode: otpCode.value.toString().trim());

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Utilities.showSnackBar(value.user.toString());
    }).catchError((e) {
      if (e.message!.contains('network'))
        Utilities.showSnackBar(AppStrings.checkInternetConnection);
      else
        Utilities.showSnackBar("Please fill correct OTP");
    });
  }

  verifyPhoneNo(String mobileNo){

    auth.verifyPhoneNumber(
      phoneNumber: '+91 '+mobileNo,
      timeout: Duration(seconds: 90),

      verificationCompleted: (PhoneAuthCredential credential) async {
         auth.signInWithCredential(credential);
      },

      codeSent: (String verificationId, int? resendToken) {
        verificationID = RxString(verificationId);
        Utilities.showSnackBar("OTP sent Successfully");
        Get.off(OtpScreen());
      },

      verificationFailed: (FirebaseAuthException error) {
        if(error.code == ''){
          print("Phone Number is incorrect");
        }
        if(error.code == 'invalid-phone-number')
          Utilities.showError('The provided phone number is not valid.');

        if(error.code == 'too-many-requests')
          Utilities.showError('Account is locked for 24 hours.');

        if (error.message!.contains('network'))
          Utilities.showSnackBar('Please check your internet connection and try again');

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },

    );
  }

  @override
  void codeUpdated() {
    otpCode = RxString(code!);
    teOtpTextController.text = code!;
  }


}