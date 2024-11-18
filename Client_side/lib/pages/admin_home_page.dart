
import 'package:flutter/material.dart';
// import 'package:cilent_side/pages/add_product_page.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/pages/admin_login_page.dart';

import '../controller/home_controller.dart';
import 'Admin_add_product_page.dart';
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl)
    {
      return Scaffold(
      appBar: AppBar(
        title:const  Text("Admin"),
        actions: [IconButton(onPressed: ()=>_dialogBuilder(context)
        , icon: const Icon(Icons.logout_rounded))],
      ),
      body: ListView.builder(
        itemCount: ctrl.products.length,
        itemBuilder: (context,index){
            return   ListTile(
              title: Text(ctrl.products[index].name ?? ''),
              subtitle:  Text((ctrl.products[index].price?? 0).toString()),
              trailing: IconButton(
                icon:const Icon(Icons.delete),
                onPressed: () { 
                  ctrl.deleteproduct((ctrl.products[index].id ?? '').toString());
                   ctrl.update();   
              },
              ),
            );
      }
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        Get.to(const AddProduct());
      },child: const Icon(Icons.add),) ,
    );
    });
  }
}



Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to logout'),
          content: const Text(
            'if you log out your account \n'
            ' you shoud log in again for your narmal use'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                Get.to(const AdminLoginPage());
              },
            ),
          ],
        );
      },
    );
  }

