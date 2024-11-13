import 'package:cilent_side/controller/Login_controller.dart';
import 'package:cilent_side/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              keyboardType: TextInputType.phone,
              controller: ctrl.loginemailctrl,
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
              keyboardType: TextInputType.phone,
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
              },style:ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ) ,child: const Text('Login') ),
              TextButton(onPressed: (){
                Get.to(const RegisterPage());
              }, child: const Text('Register New Account')),
          ],
        ),
      ),
    );

    },);
    
  }
}