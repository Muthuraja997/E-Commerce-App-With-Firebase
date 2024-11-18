import 'package:shopping_app_full/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  TextEditingController productNameCtrl=TextEditingController();
  TextEditingController productDescriptionCtrl=TextEditingController();
  TextEditingController productImagCtrl=TextEditingController();
  TextEditingController productPriceCtrl=TextEditingController();
 
  String catogary='general';
  String brand=' un brande';
  bool offer=false;

  List<Product>products=[];
  List<Product>productShow=[];
  List<Product>faverlists=[];
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
    }
    catch (e){
    
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
    
    }
    finally{
      update();
    }

  }
  
  addProduct(){
  try{
     DocumentReference doc=productCollection.doc();
  Product product =Product(
    id:doc.id,
    name: productNameCtrl.text,
    category:catogary,
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
  }
  finally{
    fetchproducts();
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
    productShow=products.where((product)=>product.category==category).toList();
    update();

    }
  }
  filterBybrand(List<String> brands){
    if(brands.isEmpty){
      productShow=products;
    }else{
      List<String> filteredBrands=brands.map((brand)=>brand).toList();
      productShow=products.where((product)=>filteredBrands.contains(product.brand ?? '')).toList();
    }
    update();
  }
  sortByprice(bool asscending){
    List<Product> sortedProducts=List<Product>.from(productShow);
    sortedProducts.sort((a,b)=>asscending? a.price!.compareTo(b.price!):b.price!.compareTo(a.price!));
    productShow=sortedProducts;
    update();
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
    update();
    }catch(e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
    }
    finally{
      fetchproducts();
    }

  }
  productfaverlists(String productid) async{
    List<Product> faverlis=products.where((product)=>product.id==productid).toList();
    faverlists.addAll(faverlis);
    update();
  }
}