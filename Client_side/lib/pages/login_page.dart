import 'package:shopping_app_full/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              controller: ctrl.loginemailctrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: 'Email Id',
                hintText:  'Enter your Email Address',

              ),
            ),

            const SizedBox(height: 20,),
            TextField(
              controller: ctrl.loginpasswordctrl,
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
                ctrl.loginuser();
                ctrl.setlogindefault();
              },style:ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ) ,child: const Text('Login') ),
              TextButton(onPressed: (){
                ctrl.setlogindefault();
                Get.to(const RegisterPage());
              }, child: const Text('Register New Account')),
          ],
        ),
      ),
    );

    },);
    
  }
}