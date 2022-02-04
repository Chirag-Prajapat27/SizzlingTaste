import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizzlingtaste/constants/AppImages.dart';

import '../constants/AppColor.dart';
import '../constants/AppFontWeight.dart';
import '../constants/AppStrings.dart';
import '../utility/Utilities.dart';

class SignIn extends StatelessWidget {
   SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(child: Image.asset(AppImages.signinBgGIF,filterQuality: FilterQuality.low,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,


              children: [

                Text(AppStrings.welcomeHeadLine,style: Utilities.setTextStyle(AppFontWeight.header,
                    AppFontWeight.bold,color: AppColor.colorPrimary),),
                SizedBox(height: 15),
                Text(AppStrings.subWelcomeHeading,style: Utilities.setTextStyle(AppFontWeight.subTitleText,
                    AppFontWeight.regular,color: AppColor.colorPrimary),),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Icon(Icons.email,color: Colors.white,size: 20,),
                      Text("  "+AppStrings.signUpWithEmail,style: Utilities.setTextStyle(AppFontWeight.titleText,
                          AppFontWeight.regular,color: AppColor.colorPrimary),),
                    ],
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))
                    ,color: Colors.lightGreenAccent,),


                ),
                SizedBox(height: 20),
                Container(
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))
                      ,color: Colors.white),

                ),
                SizedBox(height: 25),
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
