import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/controler/home_controler.dart';
import 'package:shoping_app/widgets/dropdown_button.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
      return  Scaffold(
        appBar: AppBar(title:const Text("Add Products")
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:const EdgeInsets.all(10),
          width: double.infinity,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Add New Products",style: TextStyle(fontSize: 30,color:Colors.indigoAccent,fontWeight: FontWeight.bold),),
              TextField(
                controller: ctrl.productNameCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label: const Text("Product Name"),
                  hintText: "Enter the Product Name"
                ),
              ),
               const SizedBox(height: 10,),
               TextField(
                controller: ctrl.productDescriptionCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label:  const Text("Product Description"),
                  hintText: "Enter the Product Description"
                ),
                maxLines: 4,
              ),
               const SizedBox(height: 10,),
               TextField(
                controller: ctrl.productImagCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label:  const Text("Image URL"),
                  hintText: "Enter the Product Image URL"
                ),
              ),
             const SizedBox(height: 10,),
               TextField(
                controller: ctrl.productPriceCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label:const  Text("ProductPrice"),
                  hintText: "Enter the ProductPrice"
                ),
              ),
              const SizedBox(height: 10,),
               Row(
               children:  [

              Flexible(
                child: DropDounWtn(
                  items: const ['Boots','shoe','Loafers','High heels','Ballet flats'],
                  selecteditemtext:ctrl.catogary,
                  onSelected: (selectedvalue){
                      ctrl.catogary=selectedvalue ?? 'General';
                      ctrl.update();
                  },
                  ),
                  ) ,
               Flexible(
                child: DropDounWtn(
                  items: const ['puma','adidas','bata','Sketchers','VKC'],
                  selecteditemtext: ctrl.brand,
                  onSelected: (selectedvalue){
                      ctrl.brand=selectedvalue ?? 'un brand';
                      ctrl.update();
                  },
                  )
                  ),
                ]
              ),
              const SizedBox(height: 10,),
              const Text("Offer Products ?"),
              DropDounWtn(
                items:const  ['true','false'],
                selecteditemtext:ctrl.offer.toString(),
                onSelected: (selectedvalue){
                    ctrl.offer=bool.tryParse(selectedvalue ?? 'false') ?? false;
                    ctrl.update();
                },
                ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white
                ),
                onPressed: (){

                  ctrl.AddProduct();
                }, child: const Text("Add Product"))

              
            ],
          ),
        )
        ),
    );
    }
    );
    
  }
}