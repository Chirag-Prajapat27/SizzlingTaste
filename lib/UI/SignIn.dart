import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/constants/AppImages.dart';
import 'package:sizzlingtaste/constants/AppStrings.dart';
import 'package:sizzlingtaste/controller.dart';

import '../constants/AppColor.dart';
import '../constants/AppFontWeight.dart';
import '../utility/Utilities.dart';

class SignIn extends StatelessWidget {
   SignIn({Key? key}) : super(key: key);

   final teMobileNo = TextEditingController();
   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.signinBgGIF,filterQuality: FilterQuality.low,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),

          SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    const SizedBox(height: 70),
                    Text(AppStrings.welcomeHeadLine,style: Utilities.setTextStyle(AppFontWeight.header,
                        AppFontWeight.bold,color: AppColor.colorPrimary),),
                    const SizedBox(height: 15),
                    Text(AppStrings.subWelcomeHeading,style: Utilities.setTextStyle(AppFontWeight.subTitleText,
                        AppFontWeight.regular,color: AppColor.colorPrimary),),
                    const SizedBox(height: 100),

                    Column(
                      children: [
                        TextField(
                             controller: teMobileNo,
                             // decoration: new InputDecoration.collapsed(hintText: 'Email'),0
                             decoration: InputDecoration(
                                 counter: Spacer(),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(70),
                                     borderSide: const BorderSide(color: Colors.white)),

                                 focusColor: AppColor.colorBlack,
                                 hintText: AppStrings.hintPhoneNo,
                                 hintStyle: const TextStyle(color: AppColor.colorPrimary),
                                 labelStyle: const TextStyle(color: AppColor.colorPrimary),
                                 labelText: AppStrings.phoneNo,
                                 prefixText: ' ',
                                 suffixIcon: const Icon(Icons.phone,color: AppColor.colorPrimary,)),
                            style: const TextStyle(color: AppColor.colorPrimary),
                             maxLength: 10,
                             autofocus: false,
                             obscureText: false,
                             textInputAction: TextInputAction.done,
                             keyboardType: TextInputType.emailAddress),


                    InkWell(onTap: () => {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 20,bottom: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Text(AppStrings.signIn,style: Utilities.setTextStyle(AppFontWeight.titleText,
                                AppFontWeight.regular,color: AppColor.colorPrimary),),
                          ],
                        ),
                        decoration: const BoxDecoration(borderRadius: const BorderRadius.all(const Radius.circular(20))
                          ,color: Colors.lightGreenAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
