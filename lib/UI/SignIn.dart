import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
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
          Expanded(child: Image.asset(AppImages.signinBgGIF,filterQuality: FilterQuality.low,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),),

          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,


              children: [

                Text(AppStrings.welcomeHeadLine,style: Utilities.setTextStyle(AppFontWeight.header,
                    AppFontWeight.bold,color: AppColor.colorPrimary),),
                const SizedBox(height: 15),
                Text(AppStrings.subWelcomeHeading,style: Utilities.setTextStyle(AppFontWeight.subTitleText,
                    AppFontWeight.regular,color: AppColor.colorPrimary),),
                const SizedBox(height: 20),

                TextField(
                     controller: teMobileNo,
                     // decoration: new InputDecoration.collapsed(hintText: 'Email'),0
                     decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(70),
                             borderSide: BorderSide(color: Colors.white)),

                         hintText: AppStrings.hintPhoneNo,
                         hintStyle: TextStyle(color: AppColor.colorPrimary),
                         labelStyle: TextStyle(color: AppColor.colorPrimary),
                         labelText: AppStrings.phoneNo,
                         prefixText: ' ',
                         suffixIcon: Icon(Icons.phone,color: AppColor.colorPrimary,)),

                     style: TextStyle(color: AppColor.colorPrimary),
                     maxLength: 10,
                     autofocus: false,
                     obscureText: false,
                     textInputAction: TextInputAction.done,
                     keyboardType: TextInputType.emailAddress),

                InkWell(onTap: () => Utilities.showSnackBar("Coming soon",message: 'Working on this functionality',),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        const Icon(Icons.email,color: Colors.white,size: 20,),
                        Text("  "+AppStrings.signUpWithEmail,style: Utilities.setTextStyle(AppFontWeight.titleText,
                            AppFontWeight.regular,color: AppColor.colorPrimary),),
                      ],
                    ),
                    decoration: const BoxDecoration(borderRadius: const BorderRadius.all(const Radius.circular(20))
                      ,color: Colors.lightGreenAccent,),


                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(DashBoard());
                  },
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        // SvgPicture.asset(AppImages.appleBlack24dp,color: Colors.black,height: 5,width: 5,),
                        SvgPicture.asset(AppImages.appleBlack24dp,color: AppColor.colorBlack,height: 22,width: 22),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.3),
                          child: Text(" "+AppStrings.continueWithApple,style: Utilities.setTextStyle(AppFontWeight.titleText,
                              AppFontWeight.regular,color: AppColor.colorBlack),),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(borderRadius: const BorderRadius.all(const Radius.circular(20))
                        ,color: Colors.white),

                  ),
                ),
                const SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.alreadyHaveAccount,style: Utilities.setTextStyle(AppFontWeight.subTitleText, AppFontWeight.regular,color: AppColor.colorPrimary),),
                    Text(" "+AppStrings.login,textAlign: TextAlign.center, style: TextStyle(decoration: TextDecoration.underline,color: AppColor.colorPrimary,fontFamily: 'Titillium Web Black',fontSize: AppFontWeight.subTitleText,fontWeight: AppFontWeight.regular),),
                  ],
                )


              ],
            ),
          )


        ],
      ),
    );
  }
}
