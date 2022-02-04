import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizzlingtaste/App.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/SignIn.dart';

Future<void> main() async {

  Widget _defaultWidget;

  _defaultWidget =  DashBoard();
  _defaultWidget =  SignIn();


  runApp(App(defaultWidgets: _defaultWidget));
  await Firebase.initializeApp();

}
