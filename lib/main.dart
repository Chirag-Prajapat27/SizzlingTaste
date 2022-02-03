import 'package:flutter/material.dart';
import 'package:sizzlingtaste/App.dart';
import 'package:sizzlingtaste/UI/DashBoard.dart';

void main() {

  Widget _defaultWidget;

  _defaultWidget =  const DashBoard();

  runApp(App(defaultWidgets: _defaultWidget));
}
