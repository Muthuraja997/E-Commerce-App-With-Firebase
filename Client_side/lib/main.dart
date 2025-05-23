import 'package:shopping_app_full/Adminfirebase_options.dart';
import 'package:shopping_app_full/controller/login_controller.dart';
import 'package:shopping_app_full/controller/home_controller.dart';
import 'package:shopping_app_full/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_full/pages/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: ClintFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(options: AdminFirebaseOptions.currentPlatform);
 
  //?registering my controller
  Get.put(LoginController());
  Get.put(HomeController());
  runApp(const MyApp());
}

class WebViewPlatform {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/HomePage', // Initial route
      routes: {
        '/HomePage': (context) => const HomePage(), // Registering the route
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const HomePage(),
    );
  }
}

