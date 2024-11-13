import 'package:cilent_side/controller/home_controller.dart';
import 'package:cilent_side/widgets/dropdown_button.dart';
import 'package:cilent_side/widgets/mlutiselect_dropdown.dart';
import 'package:cilent_side/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_decription _page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
        return RefreshIndicator(
          onRefresh: () async{  
            ctrl.fetchcategory();
          },
          child: Scaffold(
                appBar:AppBar( 
          title:const Text('E commerce Store',style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: (){}, icon:const Icon(Icons.logout)),
          ],
                ),
                body: Column(
          children: [
            SizedBox(height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ctrl.productCatogaries.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    ctrl.filterByCategory(ctrl.productCatogaries[index].name?? '');
          
                  },
                  child: Padding(
                    padding:  const EdgeInsets.all(6),
                    child: Chip(label:Text(ctrl.productCatogaries[index].name?? '') ),
                  ),
                ) ;
              }
            ),
            ),
            Row(
              children: [
                Flexible(
                  child: DropDounWtn(
                    items:const ['Rs: low to high','Rs: high to low'],
                    selecteditemtext:'Sort' ,
                    onSelected:(selected){
                        ctrl.sortByprice(selected=='Rs: low to high'? true:false);
                    })),
                Flexible(
                  child: MlutiselectDropdown(
                    
                    items: const ['Sony','Apple','Samsung','Fitbit'],
                     onSelectionChanged: (selecteditem ) { 
                          ctrl.filterBybrand(selecteditem);
                      },
                      )
                      ),
              ],
            ),
            Expanded(
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                ),
                itemCount: ctrl.productShow.length,
                 itemBuilder: (context,index){
                  return ProductCard(
                    name: ctrl.productShow[index].name?? '', 
                    imageUrl: ctrl.productShow[index].image?? 'https://tse2.mm.bing.net/th?id=OIP.iDE1Txt9k3LiX7zzIv2V0wHaEo&pid=Api&P=0&h=180',
                     price:ctrl.productShow[index].price?? 0, 
                     offertag: '80%', 
                    onTap:(){
                          Get.to(const ProductDecriptionPage(),arguments: {'data':ctrl.productShow[index]});
          
                    },);
                 }
                 
                 ),
            ),
          ],
                ),
          
              ),
        );

    });
    
  }
}