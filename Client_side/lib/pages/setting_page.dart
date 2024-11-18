import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/pages/address_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Address Setting'),
            onTap: () {
              // Get.to(const AddressPageForclient());
            },
          ),
           ListTile(
            title: const Text('order Details'),

             onTap: () {
              const  Text("This is a page");
            },
          )
        ],
      )
    );
  }
}