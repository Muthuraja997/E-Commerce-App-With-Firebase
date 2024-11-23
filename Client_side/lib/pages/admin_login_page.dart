

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/controller/login_controller.dart';
import 'package:shopping_app_full/pages/home_page.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl){
      return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome',
            style: TextStyle(fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple
            ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: ctrl.adminEmailctr,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone_android),
                labelText: 'Email Id',
                hintText:  'Enter your Email Address',

              ),
            ),

            const SizedBox(height: 20,),
            TextField(
              controller: ctrl.adminpasswardctr,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone_android),
                labelText: 'Password',
                hintText:  'Enter The Password',
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                ctrl.allowadmintoLogin();
                ctrl.setAdmindefault();
              },style:ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ) ,child: const Text('Login') ),
              TextButton(onPressed: (){ 
                Get.to(const HomePage());
                ctrl.setAdmindefault();
                }, child:const Text("Go to Home Page"))
          ],
        ),
      ),
    );

    },);
    
  }
}