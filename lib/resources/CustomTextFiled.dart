import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/AppColor.dart';
import '../constants/AppFontWeight.dart';
import '../utility/Utilities.dart';

typedef OnChangeCallBack = void Function(String);
typedef OnTapCallBack = void Function(String);
//ignore: must_be_immutable
class CustomTextFiled extends StatefulWidget {
  TextEditingController textField;
  String labelText;
  String hintText;
  String errorText;
  int? length;
  int? maxLine = 1;
  List<TextInputFormatter>? inputFormater=[];
  bool? readOnly;
  final OnChangeCallBack onChange;
  final OnTapCallBack? onTap;
  Color? backgroundColor = AppColor.colorPrimary;
  Color? labelColor = AppColor.colorPurple;
  Color? locationColor = AppColor.colorTheme;
  bool? isShowSuffix;
  TextInputType? textInputType = TextInputType.text;
  TextInputAction? textInputAction = TextInputAction.next;
  TextCapitalization? textCapitalization = TextCapitalization.none;

  final TextEditingController controller = TextEditingController();

  CustomTextFiled({
    Key? key,
    required this.textField,
    required this.labelText,
    required this.hintText,
    this.errorText = '',
    this.length,
    this.maxLine = 1,
    this.readOnly,
    required this.onChange,
    this.onTap,
    this.inputFormater,
    this.backgroundColor,
    this.labelColor = AppColor.colorPurple,
    this.locationColor = AppColor.colorTheme,
    this.isShowSuffix = true,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none
  }) : super(key: key);

  @override
  _CustomTextFiledState createState() {
    return _CustomTextFiledState();
  }
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (text) {
              setState(() {
                widget.errorText = '';
                widget.onChange(text);
              });
            },
            onTap: () {
              setState(() {
                widget.onTap!(widget.textField.text);
              });
            },
            textCapitalization: widget.textCapitalization!,
            maxLines: widget.maxLine,
            readOnly: widget.readOnly!,
            maxLength: widget.length!,
            inputFormatters: widget.inputFormater,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            controller: widget.textField,
            cursorColor: AppColor.colorTheme,
            autocorrect: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0, right: 0.0),
              labelText: widget.labelText,
              labelStyle: Utilities.setTextStyle(
                  AppFontWeight.titleText, AppFontWeight.regular, // was size of 10 changed to 12
                  color: widget.textField.text.isEmpty
                      ? AppColor.colorHint
                      : widget.readOnly!?AppColor.colorHint:AppColor.colorLightBlack),
              hintText: widget.hintText,
              hintStyle: Utilities.setTextStyle(
                  AppFontWeight.subTitleText, AppFontWeight.semiBold,
                  color: AppColor.colorHint),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.colorUnderlineGray),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.colorGray),
              ),
              counterText: '',
            ),
            style: Utilities.setTextStyle(
                AppFontWeight.titleText, AppFontWeight.semiBold,
                //CHANGE tfFont SIZE FROM HERE, was descriptive
                color: widget.readOnly!?AppColor.colorHint:AppColor.colorTheme),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.errorText,
            style: Utilities.setTextStyle(10, AppFontWeight.regular,
                color: Colors.red),
          )
        ],
      ),
    );
  }
}


