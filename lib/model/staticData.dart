

import 'package:sizzlingtaste/model/trendingProductModel.dart';

List<TrendingProductModel> getTrendingProducts() {
  List<TrendingProductModel>trendingProducts = [];
TrendingProductModel trendProductModel = new TrendingProductModel();

//1
trendProductModel.restoName = "Pizza Hut";
trendProductModel.productName = "Pizza";
trendProductModel.price = 299;
trendingProducts.add(trendProductModel);
trendProductModel = new TrendingProductModel();

//2
  trendProductModel.restoName = "Donald Duck";
  trendProductModel.productName = "Happy Burger";
  trendProductModel.price = 99;
  trendingProducts.add(trendProductModel);
  trendProductModel = new TrendingProductModel();

//3
  trendProductModel.restoName = "Jack Blend";
  trendProductModel.productName = "Daniels";
  trendProductModel.price = 199;
  trendingProducts.add(trendProductModel);
  trendProductModel = new TrendingProductModel();

return trendingProducts;

}