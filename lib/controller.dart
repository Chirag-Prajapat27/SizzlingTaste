import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizzlingtaste/model/sideMenuDataModel.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  List <SideMenuDataModel> sideMenuData = <SideMenuDataModel> [].obs;

  void onInit(){
  super.onInit();
  staticData();
  }


 List <SideMenuDataModel> staticData(){
    sideMenuData.add(SideMenuDataModel("Home", Icons.home_filled));
    sideMenuData.add(SideMenuDataModel("Categories", Icons.category));
    sideMenuData.add(SideMenuDataModel("Favourites", Icons.favorite_border_rounded));
    sideMenuData.add(SideMenuDataModel("Order History", Icons.history));
    sideMenuData.add(SideMenuDataModel("Share", Icons.share));
    sideMenuData.add(SideMenuDataModel("LogOut", Icons.logout));
     return sideMenuData;
  }

}