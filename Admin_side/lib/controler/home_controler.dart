import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/model/product/product.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  
  TextEditingController productNameCtrl=TextEditingController();
  TextEditingController productDescriptionCtrl=TextEditingController();
  TextEditingController productImagCtrl=TextEditingController();
  TextEditingController productPriceCtrl=TextEditingController();

  String catogary='general';
  String brand=' un brande';
  bool offer=false;
  List<Product> products=[];
  @override
  Future<void> onInit() async {
    productCollection=firestore.collection('products');
    await fetchproducts();
    super.onInit();
  }

AddProduct(){
  try{
     DocumentReference doc=productCollection.doc();
  Product product =Product(
    id:doc.id,
    name: productNameCtrl.text,
    catogary:catogary,
    description: productDescriptionCtrl.text,
    price: double.tryParse(productPriceCtrl.text),
    brand: brand,
    image: productImagCtrl.text,
    offer: offer, 
  );
  final productJson=product.toJson();
  doc.set(productJson);
  Get.snackbar('Success', ' Product Added Successfully',colorText: Colors.green);
  setValuedefault();
  } catch(e){
    Get.snackbar('Error',e.toString(),colorText: Colors.green);
    print(e);
  }
 
}
  fetchproducts() async {
    try{
      QuerySnapshot productSnapshote=await productCollection.get();
      final List<Product>retrevedProducts=productSnapshote.docs.map((doc)=>Product.fromJson(
      doc.data()as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrevedProducts);
      Get.snackbar('Success','Product Fetch Successfully',colorText: Colors.green);
    }
    catch (e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
      print(e);
    }
    finally{
      update();
    }

  }
  setValuedefault(){
    
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImagCtrl.clear();
    productPriceCtrl.clear();
    
    catogary='general';
    brand=' un brande';
    offer=false;
    update();
  }
  deleteproduct(String id) async {
    try{
    await productCollection.doc(id).delete();
    fetchproducts();
    update();

    }catch(e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
    }

  }
}