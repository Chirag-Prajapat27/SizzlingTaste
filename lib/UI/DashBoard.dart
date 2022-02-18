
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sizzlingtaste/UI/SignIn.dart';
import 'package:sizzlingtaste/constants/AppColor.dart';
import 'package:sizzlingtaste/constants/AppFontWeight.dart';
import 'package:sizzlingtaste/controller.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';
import 'package:sizzlingtaste/model/trendingProductModel.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

  final controllerData = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  String dropdownValue = 'Select Dishes';
  List<SideMenuDataModel> dropDownList = [];
  int _counter = 5;

  @override
  void initState() {
    // super.initState();
    _isLoading = true;
    // addData();
  }

  Widget myAppBarIcon() {
    return Container(
        child: Stack(
          children: [
             const Icon(
              Icons.notifications,
              size: 26,
            ),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 5),
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.colorGreen,
                  // border: Border.all(color: Colors.white, width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(_counter.toString(),
                        style: Utilities.setTextStyle(
                            AppFontWeight.descriptionText, AppFontWeight.light,
                            color: AppColor.colorPrimary)
                      // TextStyle(fontSize: 12, color: AppColor.colorPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget dropDown(context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppColor.colorPrimary),
      child: DropdownButton<String>(
          isExpanded: true,
          // value: dropdownValue,
          hint: Text(dropdownValue),
          underline: DropdownButtonHideUnderline(
              child:
              Container() //TAKEN BLANK CONTAINER JUST TO FULFILL REQUIREMENT OF HIDE DROPDOWN LINE.
          ),
          icon: Row(
            children: [const Icon(Icons.arrow_downward)],
          ),
          onChanged: (String? value) {
            dropdownValue = value!;
          },
          items: dropDownList.map((SideMenuDataModel itemss) {
            return DropdownMenuItem<String>(
                value: itemss.title, // this value show on tags
                child: Text(itemss.title.toString())); //this value show in dropdown List
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
            appBar: AppBar(title: const Text('Sizzling Taste'),
            actions: [
              InkWell(
                onTap: () {
                  print(_counter); //MSG COUNTER oN NOTIFICATION SIDE...
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 14,right: 10,bottom: 10,left: 16),
                  child: myAppBarIcon(),
                )
                ),
              ],
            ),
            body:
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 36, left: 16, right: 16),
                    color: AppColor.colorError,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.fastfood, size: 40,color: AppColor.colorPrimary,),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("Hotel The Taj",
                                style: Utilities.setTextStyle(
                                    AppFontWeight.header, AppFontWeight.bold,
                                    color: AppColor.colorPrimary)
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => DashBoard());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColor.colorPrimary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  child: const Icon(Icons.map_outlined, size: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                      enabled: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search for a Hotel',
                                        hintStyle: Utilities.setTextStyle(
                                            AppFontWeight.subTitleText,
                                            AppFontWeight.regular,
                                            color: AppColor.colorWorkingHours),
                                        contentPadding: const EdgeInsets.all(0),
                                      ),
                                      style: Utilities.setTextStyle(
                                          AppFontWeight.subTitleText,
                                          AppFontWeight.regular,
                                          color: AppColor.colorWorkingHours)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

// SEARCH BAR
                        InkWell(
                          onTap: () {
                            Get.to(() => DashBoard());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColor.colorPrimary,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  child: const Icon(Icons.search, size: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    enabled: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search for a Restaurant',
                                      hintStyle: Utilities.setTextStyle(
                                          AppFontWeight.subTitleText,
                                          AppFontWeight.regular,
                                          color: AppColor.colorWorkingHours),
                                    ),
                                    style: Utilities.setTextStyle(
                                        AppFontWeight.subTitleText,
                                        AppFontWeight.regular,
                                        color: AppColor.colorWorkingHours),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColor.colorPrimary,
                    margin: const EdgeInsets.only(top: 0),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 0, left: 0, right: 0),
                            child: (Container(
                              height: MediaQuery.of(context).size.height / 2,
                              color: AppColor.colorGray,
                              child: Column(
                                children: [
                                  // const Padding(
                                  //   padding:
                                  //   EdgeInsets.only(top: 10, bottom: 10),
                                  //   child: Icon(Icons.info_rounded,size: 18),
                                  // ),

// DROPDOWN AND GO BUTTON
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20, top: 20),
                                    child: Container(
                                      // color: Colors.blue,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.0),
                                        // border: Border.all(color: AppColor.colorGreen,width: 2),
                                        color: AppColor.colorSystemWhite,
                                      ),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 20),
                                    child: (
    /* DATA WILL COME HERE */            dropDown(context)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 120, right: 120, top: 13),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigation.push(context, SearchVendor());
                                        controllerData.getRestaurantData();
                                        print('Go Button Pressed');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        // width: ,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          color: AppColor.colorError,
                                        ),
                                        child: Text(
                                          'Go',
                                          style: Utilities.setTextStyle(
                                              AppFontWeight.subTitleText,
                                              AppFontWeight.regular,
                                              color: AppColor.colorPrimary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),

// POPULAR SERVICE
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 12, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'POPULAR DISHES',
                                  style: Utilities.setTextStyle(
                                      AppFontWeight.descriptionText,
                                      AppFontWeight.bold,
                                      color: AppColor.colorError),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.snackbar("SEE ALL", "Clicked");
                                  },
                                  child: Row(
                                    children: [
                                      Text('See All',
                                          style: Utilities.setTextStyle(
                                              AppFontWeight.descriptionText,
                                              AppFontWeight.regular)),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        size: 20,
                                        color: AppColor.colorBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/4,
                            child: ListView.builder(

                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: controllerData.trendingProducts.length,
                                itemBuilder: (context, index){

                                  return Row(
                                    children: <Widget>[
                                      Container(
                                        child: Stack(
                                          children: <Widget>[
                                            Image.network("https://www.dominos.co.in//files/items/Margherit.jpg", height: MediaQuery.of(context).size.height/2, width: MediaQuery.of(context).size.width/2,),
                                            Container(
                                              height: MediaQuery.of(context).size.height/22,
                                              width: MediaQuery.of(context).size.width/6,
                                              margin: EdgeInsets.only(left: 5, top: 5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  gradient: LinearGradient(colors: [
                                                    const Color(0xff3EA2FF).withOpacity(0.5),
                                                    const Color(0xff313AC7).withOpacity(0.5)
                                                  ])),
                                              child: Text(
                                                '\u{20B9} ${controllerData.trendingProducts[index].price.toString()}', // RUPEE SYMBOL CODE
                                                style: TextStyle(color: AppColor.colorError,fontSize: 18)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              controllerData.trendingProducts[index].productName.toString(),
                                              // trendingProductModel!.productName.toString(),
                                              style: TextStyle(color: AppColor.colorBlack, fontSize: 19),
                                            ),
                                            Text( controllerData.trendingProducts[index].restoName.toString(),
                                              // trendingProductModel!.restoName.toString(),
                                              style: TextStyle(
                                                color: AppColor.colorBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  gradient: const LinearGradient(colors: [
                                                    Color(0xff8EA2FF),
                                                    Color(0xff557AC7)
                                                  ])),
                                              child: const Text( "Add to cart",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );

                                }
                            ),
                          )

                          // GridView.count(
                          //     mainAxisSpacing: 16.0,
                          //     crossAxisSpacing: 16.0,
                          //     crossAxisCount: 3,
                          //     padding: const EdgeInsets.only(
                          //         left: 12, right: 12, bottom: 12, top: 8),
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     children: List.generate(dropDownList.length, (value) {
                          //       return Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10.0),
                          //             color: AppColor.colorPrimary,
                          //             boxShadow: [
                          //               const BoxShadow(
                          //                 color: AppColor.colorGray,
                          //                 blurRadius: 10.0,
                          //                 spreadRadius: 1.0,
                          //               )
                          //             ],
                          //           ),
                          //           child: Column(
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
                          //                 child: Image.network(
                          //                   'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/The_Taj_Mahal_main_building.jpg/200px-The_Taj_Mahal_main_building.jpg',
                          //                   height: 60,
                          //                   width: 60,
                          //                 ),
                          //               )
                          //             ],
                          //           ));
                          //     }
                          //     )
                          // ),
                          // Container(
                          //   color: AppColor.colorBlack,
                          //   height: 94,
                          //   child: InkWell(
                          //     onTap: () {
                          //       // checkIsVendorOrNot();
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Container(
                          //           height: 50,
                          //           width: MediaQuery.of(context).size.width / 2,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(15.0),
                          //             image: DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/gradientButton.png'),
                          //               fit: BoxFit.fill,
                          //             ),
                          //           ),
                          //           child: Padding(
                          //             padding:
                          //             const EdgeInsets.only(top: 20, bottom: 10),
                          //             child: Text(
                          //               'BECOME A PARTNER',
                          //               textAlign: TextAlign.center,
                          //               style: Utilities.setTextStyle(
                          //                   AppFontWeight.subTitleText,
                          //                   AppFontWeight.bold,
                          //                   color: AppColor.colorPrimary),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // _isLoading ? Loader() : Container()

                ],
              ),
            ),



            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(color: AppColor.colorError),
                      child: Text("Hi Mr ${controllerData.sharedPrefRead("userMobile").toString()}"),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controllerData.sideMenuData.length,
                    itemBuilder: (context, index) {
                      return sideMenuView(index, context);
                    },
                  ),
                ],
              ),
            ),

        );
      },
    );
  }



  sideMenuView(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.snackbar("You Clicked ${controllerData.sideMenuData[index].title}",
            " Eat It");
        switch(controllerData.sideMenuData[index].title) {
          case "LogOut":
            {
              controllerData.sharedPrefEraseAllData();
              Get.offAll(() => SignIn());
            }
            break;
          case "Home":
            {
              Get.close(0);
            }
        }
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(top: 14, left: 8, bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(controllerData.sideMenuData[index].icons, size: 26),
            const SizedBox(width: 25),
            Text(controllerData.sideMenuData[index].title.toString(),
                style: TextStyle(fontSize: AppFontWeight.titleText)
            ),
          ],
        ),
      ),
    );
  }
}

