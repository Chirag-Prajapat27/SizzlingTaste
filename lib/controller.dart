

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/OtpScreen.dart';
import 'package:sizzlingtaste/constants/AppColor.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/fireBase/WebFields.dart';
import 'package:sizzlingtaste/model/RestaurantData.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:sizzlingtaste/model/staticData.dart';
import 'package:sizzlingtaste/model/trendingProductModel.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';
import 'package:sms_autofill/sms_autofill.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin, CodeAutoFill{

  List <SideMenuDataModel> sideMenuData = <SideMenuDataModel> [].obs;
  // Create a CollectionReference called users that references the firestore collection
  // FirebaseFirestore firestore  = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Restaurant');

  List<String> errorMessageList = ['','','','','','','','',''].obs;

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
  // var isUpdate = "".obs;
  RxBool? isUpdate;
  var otpCode = "".obs;
  var verificationID = "".obs;

  late var userdata = GetStorage();
  List<TrendingProductModel> trendingProducts = [];
 RxBool isLoading = false.obs;    // loader 1/4

 loader(){                        // loader 2/4
   return Center(
        child: CupertinoActivityIndicator(
            animating: true,radius: 30,color: AppColor.colorError)
    );
  }

  @override
  void onInit(){
  super.onInit();
  trendingProducts = getTrendingProducts();
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
      isUpdate = RxString(AppStrings.updateAccount) as RxBool?;
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
      isLoading = false.obs;                         // loader 4/4
      Get.offAll(() => CreateAccountShop());
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
          Utilities.showError('Please check your internet connection and try again',message: "Please on your wifi/mobile data");
        }

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },

    );
  }

  RxBool isValidate() {
    RxBool verify = true.obs;


    for (int v = 0; v < errorMessageList.length; v++) {
      if (v == 0) {
        if (teRestroName.text.toString().trim().isEmpty) {
          errorMessageList[0] = "Please Enter Restaurant Name";
          verify = false.obs;
        } else {
          errorMessageList[0] = "";
        }
      } else if (v == 1) {
        if (teEmail.text.toString().trim().isEmpty) {
          errorMessageList[1] = "Please enter eMail";

          verify = false.obs;
        } else {
          errorMessageList[1] = "";
        }
      } else if (v == 2) {
        if (teAddress.text.toString().trim().isEmpty) {
          errorMessageList[2] = "Please enter your address";
          verify = false.obs;
        } else {
          errorMessageList[2] = "";
        }
      } else if (v == 3) {
        if (teLandmark.text.toString().trim().isEmpty) {
          errorMessageList[3] = "Please enter your Landmark";
          verify = false.obs;
        } else {
          errorMessageList[3] = "";
        }
      } else if (v == 4) {
        if (teCity.text.toString().trim().isEmpty) {
          errorMessageList[4] = "Please enter your city";
          verify = false.obs;
        } else {
          errorMessageList[4] = "";
        }
      } else if (v == 5) {
        if (teState.text.toString().trim().isEmpty) {
          errorMessageList[5] = "Please enter your state";
          verify = false.obs;
        } else {
          errorMessageList[5] = "";
        }
      } else if (v == 6) {
        if (teCountry.text.toString().trim().isEmpty) {
          errorMessageList[6] = "Please enter your Country";
          verify = false.obs;
        } else {
          errorMessageList[6] = "";
        }
      } else if (v == 7) {
        if (tePinCode.text.toString().trim().isEmpty) {
          errorMessageList[7] = "Please enter your Country";
          verify = false.obs;
        } else {
          errorMessageList[7] = "";
        }
      }
    }
    return verify;
  }

  //default function for autofill otp
  @override
  void codeUpdated() {
    otpCode = RxString(code!);
    teOtpTextController.text = code!;
  }

  // Get Restaurant Data from FireStore
  /*FutureBuilder<DocumentSnapshot> */
  getRestaurantData() async {
     var db = FirebaseFirestore.instance.collection('Restaurant');


    // QuerySnapshot<Map<String, dynamic>> data = await db.get();

    QuerySnapshot querySnapshot = await db.get();

    final alldata = querySnapshot.docs.map((e) => e.data()).toList();
    print(alldata);

    //
    // // List<Object> objList = data.docs.map<Object>((data) =>
    // // new Shop(
    // //     field1: data['field1'],
    // //     field2: List.castFrom(data['field2'])
    // // )
    // // ).toList();
    // print(data.size);

  }

  // addRestaurantData(HashMap<String, Object> data){
  addRestaurantData(String restaurantName,String email,String address,String landmark,String city,String state,String country,String pinCode,String mobileNo){

    Map<String, Object?> requestParm = toHashMap( restaurantName, email, address,
         landmark, city, state, country, pinCode, mobileNo);

    users.doc().set(requestParm).then((value) => Utilities.showSnackBar("Data add successfully"))
        .catchError((onError)=> Utilities.showError("Failed to add user: $onError"));

    print("MY DATA IS:-- $requestParm");
  }

  Map<String, Object> toHashMap(String restaurantName,String email,String address,
      String landmark,String city,String state,String country,String pinCode,String mobileNo) => {
    WebFields.RESTAURANT_NAME : restaurantName,
    WebFields.EMAIL : email,
    WebFields.ADDRESS : address,
    WebFields.LANDMARK : landmark,
    WebFields.CITY : city,
    WebFields.STATE : state,
    WebFields.COUNTRY : country,
    WebFields.PINCODE : pinCode,
    WebFields.RESTAURANT_MOBILE : mobileNo
  };






}
