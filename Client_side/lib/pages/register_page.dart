import 'package:cilent_side/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/Login_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<LoginController>(builder: (ctrl){
     return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(

        color: Colors.blueGrey[50],
      
        ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Text('Create Your account',
          style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.deepPurple),
          ),
        TextField(
            keyboardType: TextInputType.phone,
            controller: ctrl.registerNamectrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.phone_android),
              labelText: 'Your Name',
              hintText: 'Enter your Name',
            ),
        ),
        const SizedBox(height: 20,),
        TextField(
            keyboardType: TextInputType.phone,
            controller: ctrl.registerEmailctrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.phone_android),
              labelText: 'Email Id',
              hintText: 'Enter your Email Address',
            ),
        ),
        const SizedBox(height: 20,),
         TextField(
            keyboardType: TextInputType.phone,
            controller: ctrl.registerPasswardctrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.phone_android),
              labelText: 'Passward',
              hintText: 'Enter The New Passward',
            ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          ctrl.AddUser();
        }, style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
        ),
        child:const Text('Register')),
        const SizedBox(height: 20,),
        TextButton(onPressed: (){
           Get.to(const LoginPage());
        }, child:const Text('Login')),
        ],
      ),
      ),
    );

    });
    
  }
}