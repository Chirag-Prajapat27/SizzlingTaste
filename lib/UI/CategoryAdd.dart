
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizzlingtaste/constants/AppColor.dart';
import 'package:sizzlingtaste/constants/AppFontWeight.dart';
import 'package:sizzlingtaste/utility/Utilities.dart';

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.colorNoLogo,
      appBar: AppBar(title: const Text("Categoty Add"),backgroundColor: AppColor.colorError,),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index){
              return viewCart(index);
            })

      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Utilities.showSnackBar('Done',snackbarPositonBottom: false);
          },
      child: Icon(Icons.add,size: 24),),


    );
  }

  viewCart(int index) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
      child: Card(
        elevation: 3.0,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/sizzling-taste.appspot.com/o/Products%2FMargherit_Pizza.jpg?alt=media&token=55eaf888-c28d-4150-8b37-8734eb504ee3",
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/sizzling-taste.appspot.com/o/fast-food-place-holder.jpg?alt=media&token=afa38e93-b624-4025-ad6e-a5896a7fa7b8'),
                    height: 70,
                    width: 70,
                  ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left:10,top: 0),
                 child: Text("Pizza",style: Utilities.setTextStyle(AppFontWeight.titleSubText, AppFontWeight.semiBold),),
               ),
             ],
           ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_forward_ios,color: AppColor.colorGreen,size: 25),
          )
          ],
        ),
      ),
    );
  }
}
