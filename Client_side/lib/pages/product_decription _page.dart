import 'package:cilent_side/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDecriptionPage extends StatelessWidget {
  const ProductDecriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product products =Get.arguments['data'];
    return Scaffold(
      appBar: AppBar( title: const Text('Product Name'),
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                ),
                labelText: 'Enter your Billing Addresss',

              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigoAccent
                ),
                onPressed:(){}, child: const Text('Buy Now',style: TextStyle(fontSize: 18,color: Colors.white),),),
            )
          ],
        ),
      ),
    );
  }
}