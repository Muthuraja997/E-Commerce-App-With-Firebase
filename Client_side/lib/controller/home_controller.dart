import 'package:cilent_side/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;



  List<Product>products=[];
  List<Product>productShow=[];
  List<ProductCategory> productCatogaries=[];
    @override
    Future<void> onInit() async {
      productCollection=firestore.collection('products');
      categoryCollection=firestore.collection('category');
      await fetchcategory();
      await fetchproducts();
      super.onInit();
    }
  fetchproducts() async {
    try{
      QuerySnapshot productSnapshote=await productCollection.get();
      final List<Product>retrevedProducts=productSnapshote.docs.map((doc)=>Product.fromJson(
      doc.data()as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrevedProducts);
      productShow.assignAll(products);
      Get.snackbar('Success','Product Fetch Successfully',colorText: Colors.green);
    }
    catch (e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
    
    }
    finally{
      update();
    }

  }
  
  
  fetchcategory() async {
    try{
      QuerySnapshot categorySnapshote=await categoryCollection.get();
      final List<ProductCategory>retrevedcategories=categorySnapshote.docs.map((doc)=>ProductCategory.fromJson(
      doc.data()as Map<String,dynamic>)).toList();
      productCatogaries.clear();
      productCatogaries.assignAll(retrevedcategories);
    }
    catch (e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
      
    }
    finally{
      update();
    }

  }

  filterByCategory(String category){
    if(category=='All')
    {
      productShow=products;
      update();
    }
    else{
    productShow.clear();
    productShow=products.where((product)=>product.category==category).toList();
    update();
    }
  }
  filterBybrand(List<String> brands){
    if(brands.isEmpty){
      productShow=products;
    }else{
      List<String> Brands=brands.map((brand)=>brand).toList();
      productShow=products.where((product)=>Brands.contains(product.brand ?? '')).toList();
    }
    update();
  }
  sortByprice(bool asscending){
    List<Product> sortedProducts=List<Product>.from(productShow);
    sortedProducts.sort((a,b)=>asscending? a.price!.compareTo(b.price!):b.price!.compareTo(a.price!));
    productShow=sortedProducts;
    update();
  }
}