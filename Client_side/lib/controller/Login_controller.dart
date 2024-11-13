import 'package:cilent_side/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user/user.dart';

class LoginController extends GetxController {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    late CollectionReference userCollecton;
   
    TextEditingController registerNamectrl=TextEditingController();
    TextEditingController registerEmailctrl=TextEditingController();
    TextEditingController registerPasswardctrl=TextEditingController();
    TextEditingController loginemailctrl=TextEditingController();
    TextEditingController loginpasswordctrl=TextEditingController();


    @override
  void onInit() {
    userCollecton=firestore.collection('users');
    
    super.onInit();
  }

  AddUser() async {
    try{
      if(registerNamectrl.text.isEmpty || registerEmailctrl.text.isEmpty || registerPasswardctrl.text.isEmpty){
        Get.snackbar('Error','Please fill the feild',colorText: Colors.red);
        return;
      }
      if (!GetUtils.isEmail(registerEmailctrl.text)) {
      Get.snackbar('Error', 'Enter a valid email', colorText: Colors.red);
      return;
    }
     QuerySnapshot querySnapshot = await userCollecton
        .where('email', isEqualTo: registerEmailctrl.text)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Get.snackbar('Error', 'Email already exists', colorText: Colors.red);
      return;
    }
      DocumentReference doc=userCollecton.doc();
      User user =User(
      id:doc.id,
      name:registerNamectrl.text,
      email:registerEmailctrl.text,
      passward:registerPasswardctrl.text,
    );
    final userJson=user.toJson();
    doc.set(userJson);
    Get.snackbar('Success', ' User Added Successfully',colorText: Colors.green);
    registerNamectrl.clear();
    registerEmailctrl.clear();
    registerPasswardctrl.clear();
    
    } catch(e){
      Get.snackbar('Error',e.toString(),colorText: Colors.green);
   
    }
  
  }
    
  loginuser(){
    try{
      if(loginemailctrl.text.isEmpty || loginpasswordctrl.text.isEmpty){
        Get.snackbar('Error', 'Please Fill all The feild');
        return;
      }
      Get.to(const HomePage());
    }catch(e){
      Get.snackbar('Error', e.toString(),colorText: Colors.red);
    }

  }
 

}