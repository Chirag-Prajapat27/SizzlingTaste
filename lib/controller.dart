import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/OtpScreen.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/fireBase/WebFields.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';
import 'package:sms_autofill/sms_autofill.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin, CodeAutoFill{

  List <SideMenuDataModel> sideMenuData = <SideMenuDataModel> [].obs;
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('Restaurant');

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

  late var userdata = GetStorage();


  @override
  void onInit(){
  super.onInit();
  userdata = GetStorage();
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

void sharedPrefWrite(String key,String value){
    userdata.write(key, value);
}

String sharedPrefRead(String key){
    return userdata.read(key);
}

void getUserMobileNo(String key) async {
  Obx(()=>phoneNoText = userdata.read(key));
}

void sharedPrefRemove(String key){
    userdata.remove(key);
}
void sharedPrefEraseAllData(){
    userdata.erase();
}


//side menuData list
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
      Get.offAll(() => CreateAccountShop());
    }
  }

  // for verify OTP and user in firebase auth.
  otpVerify() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value, smsCode: otpCode.value.toString().trim());

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {

      Utilities.showSnackBar(value.user!.phoneNumber.toString(),message: "Login Successfully Done");

      sharedPrefWrite("userMobile", value.user!.phoneNumber.toString());


      Get.to(() => DashBoard());
      print(value.user.toString());
    }).catchError((e) {
      if (e.message!.contains('network')) {
        Utilities.showSnackBar(AppStrings.checkInternetConnection);
      } else {
        Utilities.showError("Please fill correct OTP");
      }
    });
  }

  // For phone authentication and sent OTP
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
        Get.off(() => OtpScreen());
      },

      verificationFailed: (FirebaseAuthException error) {
        if(error.code == ''){
          print("Phone Number is incorrect");
        }
        if(error.code == 'invalid-phone-number') {
          Utilities.showError('The provided phone number is not valid.',message: "Please fill correct mobile no.");
        }

        if(error.code == 'too-many-requests') {
          Utilities.showError('Account is locked for 24 hours.',message: "Try again.");
        }

        if (error.message!.contains('network')) {
          Utilities.showSnackBar('Please check your internet connection and try again',message: "Please on your wifi/mobile data");
        }

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },

    );
  }

  bool checkBlankTextField(){
    var verify = true;
    if(teRestroName.text.trim().toString().isEmpty) {
      verify = false;
    } else if(teAddress.text.trim().toString().isEmpty) {
      verify = false;
    } else if(teEmail.text.trim().toString().isEmpty) {
      verify = false;
    } else if(teCity.text.trim().toString().isEmpty) {
      verify = false;
    } else if(teState.text.trim().toString().isEmpty) {
      verify = false;
    } else if(teCountry.text.trim().toString().isEmpty) {
      verify = false;
    } else {
      verify = false;
    }
    return verify;
  }


  // addRestaurantData(HashMap<String, Object> data){
  addRestaurantData(String restauranteName,String email,String address,
      String landmark,String city,String state,String country,String pinCode,String mobileNo){

    Map<String, Object?> requestParm = toHashMap( restauranteName, email, address,
         landmark, city, state, country, pinCode, mobileNo);

    users.doc().update(requestParm).then((value) => Utilities.showSnackBar("Data add successfully"))
        .catchError((onError)=> Utilities.showError("Failed to add user: $onError"));

  }

  //default function for autofill otp
  @override
  void codeUpdated() {
    otpCode = RxString(code!);
    teOtpTextController.text = code!;
  }

  Map<String, String> toHashMap(String restauranteName,String email,String address,
      String landmark,String city,String state,String country,String pinCode,String mobileNo) => {
    WebFields.SHOP_NAME : restauranteName,
    WebFields.email : email,
    WebFields.address : address,
    WebFields.landmark : landmark,
    WebFields.city : city,
    WebFields.state : state,
    WebFields.country : country,
    WebFields.pinCode : pinCode,
    WebFields.mobileNo : mobileNo
  };


}