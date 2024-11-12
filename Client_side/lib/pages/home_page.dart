import 'package:cilent_side/widgets/dropdown_button.dart';
import 'package:cilent_side/widgets/mlutiselect_dropdown.dart';
import 'package:cilent_side/widgets/product_card.dart';
import 'package:flutter/material.dart';

import 'product_decription _page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            itemCount: 10,
            itemBuilder: (context,index){
              return const Padding(
                padding:  EdgeInsets.all(6),
                child: Chip(label:Text("Catogary") ),
              ) ;
            }
          ),
          ),
          Row(
            children: [
              Flexible(child: DropDounWtn(items:const ['Rs: low to high','Rs: high to low'],selecteditemtext:'Sort' ,onSelected:(selected){})),
              Flexible(child: MlutiselectDropdown(items: const ['item1','item2','item3'], onSelectionChanged: (selecteditem ) {  },)),
            ],
          ),
          Expanded(
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              ),
              itemCount: 10,
               itemBuilder: (context,index){
                return ProductCard(
                  name: 'Shopping', 
                  imageUrl: 'https://tse2.mm.bing.net/th?id=OIP.iDE1Txt9k3LiX7zzIv2V0wHaEo&pid=Api&P=0&h=180',
                   price:1000000 , 
                   offertag: '80%', 
                  onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const  ProductDecriptionPage()));

                  },);
               }
               
               ),
          ),
        ],
      ),

    );
  }
}