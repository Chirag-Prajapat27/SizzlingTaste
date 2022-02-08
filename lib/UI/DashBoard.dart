import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/constants/AppColor.dart';
import 'package:sizzlingtaste/constants/AppFontWeight.dart';
import 'package:sizzlingtaste/controller.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

    final controllerData = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
            appBar: AppBar(title: const Text('Sizzling Taste')),
            body: const Center(child: Text("Welcome to the Land of Food :')")),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: const DrawerHeader(
                      decoration: BoxDecoration(color: AppColor.colorError),
                      child: Text("Hi Mr ${controllerData.sharedPrefRead("userMobile")}"),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controllerData.sideMenuData.length,
                      itemBuilder: (context, index) {
                        InkWell(
                          onTap: (){
                            controllerData.sharedPrefEraseAllData();
                          },
                        );
                        return sideMenuView(index, context);
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  sideMenuView(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.snackbar("You Clicked ${controllerData.sideMenuData[index].title}",
            " Eat It");
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(top: 14, left: 8, bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(controllerData.sideMenuData[index].icons, size: 26),
            SizedBox(width: 25),
            Text(controllerData.sideMenuData[index].title.toString(),
                style: TextStyle(fontSize: AppFontWeight.titleText)
            ),
          ],
        ),
      ),
    );
  }
}









