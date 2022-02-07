import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/AppColor.dart';
import '../constants/AppFontWeight.dart';
import '../utility/Utilities.dart';


typedef OnTapCallBack = void Function();
//ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  final OnTapCallBack onTapButton;
  String buttonTitle = "";
  double? height = 50;
  Color? backGroundColor = AppColor.colorBlack;
  bool? isBorder = false;
  Color? buttonTextColor = AppColor.colorPrimary;
  double borderRadius = 5;

  CustomButton(
      {Key? key,
      required this.buttonTitle,
      this.height = 50,
      this.isBorder = false,
      this.backGroundColor = AppColor.colorBtnGreen,
      this.buttonTextColor = AppColor.colorPrimary,
        this.borderRadius = 5,
      required this.onTapButton})
      : super(key: key);

  @override
  _CustomButtonState createState() {
    buttonTitle = this.buttonTitle;
    height = this.height;
    backGroundColor = this.backGroundColor;
    buttonTextColor = this.buttonTextColor;

    return _CustomButtonState();
  }
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTapButton();
      },
      child: Container(
        // constraints: BoxConstraints(maxWidth: 300),
        height: widget.height,
        decoration: new BoxDecoration(
          color: widget.backGroundColor,
          border: Border.all(
              width: 1.0,
              color: widget.isBorder!
                  ? AppColor.colorPrimary
                  : Colors.transparent),
          borderRadius: new BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.buttonTitle,
                style: Utilities.setTextStyle(AppFontWeight.titleText, AppFontWeight.semiBold,
                    color: widget.buttonTextColor!)),
          ],
        ),
      ),
    );
  }
}
