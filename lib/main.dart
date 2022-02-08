import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizzlingtaste/App.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/SignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget _defaultWidget;

  // _defaultWidget =  DashBoard();
  _defaultWidget =  SignIn();
  // _defaultWidget =  CreateAccountShop();

  runApp(App(defaultWidgets: _defaultWidget));

}
