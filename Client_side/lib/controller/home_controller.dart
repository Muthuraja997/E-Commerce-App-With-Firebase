import 'package:shopping_app_full/model/cart/cart.dart';
import 'package:shopping_app_full/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;
  late CollectionReference cartCollection;
  TextEditingController productNameCtrl=TextEditingController();
  TextEditingController productDescriptionCtrl=TextEditingController();
  TextEditingController productImagCtrl=TextEditingController();
  TextEditingController productPriceCtrl=TextEditingController();
  TextEditingController cartIdCtrl=TextEditingController();
  String catogary='general';
  String brand=' un brande';
  bool offer=false;
  List<Product>productforcart=[];
  List<Product>products=[];
  List<Product>productShow=[];
  List<Product>faverlists=[];
  List<Cart>cartlist=[];
  List<ProductCategory> productCatogaries=[];
    @override
    Future<void> onInit() async {
      productCollection=firestore.collection('products');
      categoryCollection=firestore.collection('category');
      cartCollection=firestore.collection('Carts');
      await fetchcategory();
      await fetchproducts();
      await fetchcartids();
      await collectproductforcart();
      super.onInit();
    }
    fetchcartids() async {
      try{
        QuerySnapshot cartSnapshote=await cartCollection.get();
        final List<Cart>retrevedcarts=cartSnapshote.docs.map((doc)=>Cart.fromJson(doc.data() as Map<String,dynamic>)).toList();
        cartlist.clear();
        cartlist.assignAll(retrevedcarts);
      }
      catch(e){
        Get.snackbar("Error",e.toString(),colorText: Colors.red);
      }
      finally{
        update();
      }

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
  
  addCarts(String valuesofcart) async {
    try{
      await fetchcartids();
      bool v= false;
      for(var i in cartlist){
        if(i.productid==valuesofcart){
          v=true;
          break;
        }
      }
      if(v==true){
        Get.snackbar("Already this prodect in Cart", "If you want remove from cart you should remove from cart page");
        return;
      }
      else{
      DocumentReference doc=cartCollection.doc();
      Cart cart=Cart(
        productid: valuesofcart,
      );
      final cartJson=cart.toJson();
      await doc.set(cartJson);
      Get.snackbar('Success', ' Product Added Successfully',colorText: Colors.green);
     await fetchcartids();
     collectproductforcart();
     }
    }
    catch(e){
      Get.snackbar("Error", e.toString(),colorText: Colors.red);
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
  deleteproductcart(String productid) async {
    try{
    QuerySnapshot querySnapshot = await cartCollection.where('productid', isEqualTo: productid).get();
    
    if (querySnapshot.docs.isNotEmpty) {
      
      for (var doc in querySnapshot.docs) {
        
        await cartCollection.doc(doc.id).delete();
      }
      await fetchcartids();
      collectproductforcart();
      Get.snackbar("Success", "cart product has been deleted from cart list",colorText: Colors.green);
    } else {
      Get.snackbar("Error", "Product not found in the cart list", colorText: Colors.red);
    }
    }catch(e){
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
    }
    finally{
      update();
    }
  }
  productfaverlists(String productid) async{
    List<Product> faverlis=products.where((product)=>product.id==productid).toList();
    faverlists.addAll(faverlis);
    update();
  }
  collectproductforcart(){
    fetchcartids();
    productforcart.clear();
    for(var i in cartlist){
      List<Product>allcard=products.where((product)=>product.id==i.productid).toList();
      productforcart.addAll(allcard);
    }
    update();
  }
}