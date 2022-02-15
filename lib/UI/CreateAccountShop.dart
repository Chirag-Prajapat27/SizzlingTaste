import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/resources/CustomButton.dart';
import 'package:sizzlingtaste/resources/CustomTextFiled.dart';

import '../constants/AppFontWeight.dart';
import '../controller.dart';
import '../utility/Utilities.dart';


class CreateAccountShop extends StatelessWidget {
   CreateAccountShop( {Key? key}) : super(key: key);
   HomeController controller = Get.put(HomeController());
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


   @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("controller.isUpdate.value",style: Utilities.setTextStyle(
        AppFontWeight.subHeader, AppFontWeight.semiBold),)),

        body: Obx(()=> Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  // Obx(()=>
                CustomTextFiled(
                textField: controller.teRestroName,
                labelText: AppStrings.restaurantName,
                hintText: AppStrings.restaurantName,
                length: 140,
                readOnly: false,
                errorText: controller.errorMessageList[0],
                onChange: (text){
                  controller.isValidate();}),
            // ),

                CustomTextFiled(
                    textField: controller.teEmail,
                    labelText: AppStrings.email,
                    readOnly: false,
                    length: 140,
                    hintText: AppStrings.email,
                    errorText: controller.errorMessageList[1],
                    onChange: (text) {
                      controller.isValidate();
                    }),

                CustomTextFiled(
                    textField: controller.teAddress,
                    labelText: AppStrings.address,
                    hintText: AppStrings.address,
                    length: 140,
                    readOnly: false,
                    errorText: controller.errorMessageList[2],
                    onChange: (text) {
                      controller.isValidate();
                    }),

                  CustomTextFiled(
                      textField: controller.teLandmark,
                      labelText: AppStrings.landmark,
                      hintText: AppStrings.landmark,
                      readOnly: false,
                      length: 140,
                      errorText: controller.errorMessageList[3],
                      onChange: (text){
                        // controller.isValidate();
                      }),


                  CustomTextFiled(
                      textField: controller.teCity,
                      labelText: AppStrings.city,
                      hintText: AppStrings.city,
                      readOnly: false,
                      length: 140,
                      errorText: controller.errorMessageList[4],
                      onChange: (text){
                        controller.isValidate();
                      }),



                    CustomTextFiled(
                        textField: controller.teState,
                        labelText: AppStrings.state,
                        hintText: AppStrings.state,
                        readOnly: false,
                        length: 140,
                        errorText: controller.errorMessageList[5],
                        onChange: (text){
                          controller.isValidate();
                        }),

                    CustomTextFiled(
                        textField: controller.teCountry,
                        labelText: AppStrings.country,
                        hintText: AppStrings.country,
                        readOnly: false,
                        length: 140,
                        errorText: controller.errorMessageList[6],
                        onChange: (text){
                          controller.isValidate();
                        }),

                  CustomTextFiled(
                      textField: controller.tePinCode,
                      labelText: AppStrings.pinCode,
                      hintText: AppStrings.pinCode,
                      readOnly: false,
                      length: 6,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      errorText: controller.errorMessageList[7],
                      onChange: (text){
                        // controller.isValidate();
                      }),


                  CustomButton(
                    buttonTitle: AppStrings.submit,
                    onTapButton: () {
                      if (controller.isValidate().isTrue) {
                        controller.addRestaurantData(
                            controller.teRestroName.text.toString(),
                            controller.teEmail.text.toString(),
                            controller.teAddress.text.toString(),
                            controller.teLandmark.text.toString(),
                            controller.teCity.text.toString(),
                            controller.teState.text.toString(),
                            controller.teCountry.text.toString(),
                            controller.tePinCode.text.toString(),
                            controller.sharedPrefRead("userMobile").toString()
                            // controller.teMobileNo.text.toString()
                            );
                        Get.offAll(() => DashBoard());
                      }
                      else{
                        controller.isValidate();
                      }
                    }),
              ],
        ),
              ),
            ),
          ),
      ));
  }


}
