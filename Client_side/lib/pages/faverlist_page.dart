import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/controller/home_controller.dart';
import 'package:shopping_app_full/widgets/product_card.dart';

class FaverlistPage extends StatelessWidget {
  const FaverlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder:(ctrl){
      return Scaffold(
    
        appBar: AppBar(title: const Text('your foverlist product'),),
        body: ListView.builder(
          itemCount: ctrl.faverlists.length,
          itemBuilder: (context,index){
          return ProductCard(
            name: ctrl.faverlists[index].name??'', imageUrl: ctrl.faverlists[index].image??'', price: ctrl.faverlists[index].price?? 0, offertag: '80%', onTap:(){},description:  ctrl.faverlists[index].description?? '');
        })
        );
      
    
    }
    
    
    );
    
  }
}