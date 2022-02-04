import 'package:flutter/material.dart';
import 'package:sizzlingtaste/App.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/SignIn.dart';

void main() {

  Widget _defaultWidget;

  _defaultWidget =  DashBoard();
  _defaultWidget =  SignIn();


  runApp(App(defaultWidgets: _defaultWidget));

}
