
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/AppColor.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key,this.defaultWidgets}) : super(key: key);
  final Widget? defaultWidgets;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sizzling Taste App',

      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: bgWhite,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          canvasColor: bgSecondaryWhite),
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor),
      themeMode: ThemeMode.system,


      // theme: ThemeData(
      //   primarySwatch: Colors.blue),
      home: defaultWidgets,
    );
  }
}

