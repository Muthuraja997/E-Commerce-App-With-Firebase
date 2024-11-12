
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/controler/home_controler.dart';
import 'package:shoping_app/pages/home_page.dart';

import 'firebase_options.dart';

void main() async {
  //?regeistering my controller
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(HomeController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home: HomePage(),
      
    );
  }
}