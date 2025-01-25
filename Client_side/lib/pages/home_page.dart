import 'package:shopping_app_full/controller/home_controller.dart';
import 'package:shopping_app_full/pages/admin_login_page.dart';
import 'package:shopping_app_full/pages/faverlist_page.dart';
import 'package:shopping_app_full/pages/login_page.dart';
import 'package:shopping_app_full/pages/setting_page.dart';
import 'package:shopping_app_full/widgets/dropdown_button.dart';
import 'package:shopping_app_full/widgets/mlutiselect_dropdown.dart';
import 'package:shopping_app_full/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_to_cart.dart';
import 'product_decription_page.dart';

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
                  
                automaticallyImplyLeading: false,
                title:const Text('Muthu\'s Store',style: TextStyle(fontWeight: FontWeight.bold),),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 194, 252, 251),
                      // Color.fromARGB(255, 225, 235, 234),
                      Color.fromARGB(255, 51, 229, 187),
                      Color.fromARGB(255, 111, 254, 252),

                    ])
                  ),
                ),
          actions: [
            IconButton(onPressed: (){
              Get.to(const AddToCart());
            }, icon: const Icon(Icons.add_shopping_cart,color: Colors.white,)),
            IconButton(onPressed: (){
              Get.to(const SettingPage());
            }, icon:const Icon(Icons.settings,color: Colors.white)),
            IconButton(onPressed: ()=>_dialogBuilder(context,),
             icon:const Icon(Icons.logout,color: Colors.white)),
             IconButton(onPressed: ()
            {
              Get.to(const FaverlistPage());
            },
            icon:const Icon(Icons.favorite,color: Colors.red,),),
            IconButton(onPressed: (){
              Get.to(const AdminLoginPage());
            }, icon:const Icon(Icons.admin_panel_settings_sharp,color: Colors.lightGreenAccent,)),
            
          ],
            ),
          
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 252, 253, 252),
                      
                      Color.fromARGB(255, 247, 250, 250)
                    ])
                  ),
                  child: Column(
                    
                            children: [
                            
                              Column(
                                
                              children: [
                               
                  
                  Padding(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                  child: TextField(
                  onChanged: (value) {
                    ctrl.searchProductByName(value);
                  },
                  decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search product',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                                ),
                              )  ,
                                ),
                                
                                ],
                              ),
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
                      }
                      )
                      ),
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
                                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                       description: ctrl.productShow[index].description??'',
                      onTap:(){
                            Get.to(const ProductDecriptionPage(),arguments: {'data':ctrl.productShow[index]});
                            
                      },);
                   }
                   
                   ),
                              ),
                            ],
                  ),
                ),
          
              ),
        );

    });
    
  }
}


Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to logout'),
          content: const Text(
            'if you log out your account \n'
            ' you shoud log in again for your narmal use'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                Get.to(const LoginPage());
              },
            ),
          ],
        );
      },
    );
  }

