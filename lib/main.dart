import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizzlingtaste/App.dart';
import 'package:sizzlingtaste/UI/CreateAccountShop.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';
import 'package:sizzlingtaste/UI/SignIn.dart';

import 'controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Widget _defaultWidget;

  final storageData = GetStorage();
  var userMobile = storageData.read("userMobile");

  if(userMobile != ""){
    _defaultWidget = SignIn();
  }else {
    _defaultWidget = DashBoard();
  }

  // _defaultWidget =  DashBoard();
  // _defaultWidget =  SignIn();

  runApp(App(defaultWidgets: _defaultWidget));


}
