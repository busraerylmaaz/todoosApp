import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoos/firebase_options.dart';
import 'package:todoos/pages/login_register_page.dart';
import 'package:todoos/pages/home_page.dart';
import 'package:todoos/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(() {
        final authController = Get.find<AuthController>();
       
        if (authController.user.value != null) {
          return HomePage();
        } else {
          return const LoginRegisterPage();
        }
      }),
    );
  }
}
