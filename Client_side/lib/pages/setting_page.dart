import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'address_for_client.dart';

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
              Get.to(const  AddressForClient());
            },
          ),
           ListTile(
            title: const Text('order Details'),

             onTap: () {
              
            },
          )
        ],
      )
    );
  }
}