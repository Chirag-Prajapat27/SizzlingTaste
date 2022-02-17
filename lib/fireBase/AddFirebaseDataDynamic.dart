

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizzlingtaste/fireBase/WebFields.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';


class AddFireData{

// Create a CollectionReference called users that references the firestore collection
CollectionReference users = FirebaseFirestore.instance.collection('Restaurant');

addRestaurantData(String restaurantName,String email,String address,String landmark,String city,String state,String country,String pinCode,String mobileNo){

Map<String, Object?> requestParm = toHashMap( restaurantName, email, address,
landmark, city, state, country, pinCode, mobileNo);

users.doc().set(requestParm).then((value) => Utilities.showSnackBar("Data add successfully"))
    .catchError((onError)=> Utilities.showError("Failed to add user: $onError"));

}

Map<String, Object> toHashMap(String restaurantName,String email,String address,
String landmark,String city,String state,String country,String pinCode,String mobileNo) => {
WebFields.RESTAURANT_NAME : restaurantName,
WebFields.EMAIL : email,
WebFields.ADDRESS : address,
WebFields.LANDMARK : landmark,
WebFields.CITY : city,
WebFields.STATE : state,
WebFields.COUNTRY : country,
WebFields.PINCODE : pinCode,
WebFields.RESTAURANT_MOBILE : mobileNo
};

}
