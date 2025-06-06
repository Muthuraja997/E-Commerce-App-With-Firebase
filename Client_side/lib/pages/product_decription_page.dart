import 'package:shopping_app_full/controller/home_controller.dart';
import 'package:shopping_app_full/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payement_gatway.dart';

// import 'package:flutter_paypal/flutter_paypal.dart';

class ProductDecriptionPage extends StatelessWidget {
  const ProductDecriptionPage({super.key});
  @override
  Widget build(BuildContext context) {
  int val=0;
    Product products =Get.arguments['data'];
    return GetBuilder<HomeController>(builder:(ctrl){
        return Scaffold(
      appBar: AppBar( title: const Text('Product Name'),
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 300.0),
              
                
                child: IconButton(onPressed: (){
                  if (val==0){
                  ctrl.productfaverlists(products.id??'');
                  val=1;
                  }
                  else{
                    val=0;
                  }
                },
                 icon:const Icon(Icons.favorite,),color: val==0 ? Colors.lightGreen:Colors.red
                ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                products.image?? 'https://tse4.mm.bing.net/th?id=OIP.f66kbA8yVCc-2A9Wr9dLaQHaGi&pid=Api&P=0&h=180',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 20,),
             Text(products.name?? '',style:const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),
           const  SizedBox(height: 20,),
             Text(products.description??'' ,style: const TextStyle(fontSize: 16,height: 1.5),),
           const  SizedBox(height: 20,),
             Text('Rs: ${products.price.toString()}' ,style: const TextStyle(color: Colors.green,fontSize: 23,fontWeight: FontWeight.bold),),
           const  SizedBox(height: 20,),
            // TextField(
            //   maxLines: 3,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),

            //     ),
            //     labelText: 'Enter your Billing Addresss',

            //   ),
            // ),
            const SizedBox(height: 20,),
             SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigoAccent
                ),
                
                onPressed:(){
                ctrl.collectproductforcart();
                ctrl.addCarts(products.id??'');
                }
                , child: const Text('Add To Cart',style: TextStyle(fontSize: 18,color: Colors.white),),),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigoAccent
                ),
                onPressed:(){
                  Get.to(const PayPalIntegration());
                }
                , child: const Text('Buy Now',style: TextStyle(fontSize: 18,color: Colors.white),),),
            )
          ],
        ),
      ),
    );
    },
    );
  }
}
