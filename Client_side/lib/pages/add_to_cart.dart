import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/controller/home_controller.dart';
import 'package:shopping_app_full/pages/cart_product_description.dart';

import '../widgets/product_card.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
      return Scaffold(
        appBar:AppBar( 
            // automaticallyImplyLeading: false,
          title:const Text('Your Cart' ,style: TextStyle(fontWeight: FontWeight.bold),),

      ),
      
      body: Column(
      
              children: [
                
                Expanded(
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                ),
                itemCount: ctrl.productforcart.length,
                 itemBuilder: (context,index){
                  return ProductCard(
                    name: ctrl.productforcart[index].name?? '', 
                    imageUrl: ctrl.productforcart[index].image?? 'https://tse2.mm.bing.net/th?id=OIP.iDE1Txt9k3LiX7zzIv2V0wHaEo&pid=Api&P=0&h=180',
                     price:ctrl.productforcart[index].price?? 0, 
                     offertag: '80%', 
                    onTap:(){
                          Get.to(const CartProductDescription(),arguments: {'data':ctrl.productforcart[index]});
                    },);
                 }
                 
                 ),
            ),
              ],
            )
      );
        
    });
  }
}