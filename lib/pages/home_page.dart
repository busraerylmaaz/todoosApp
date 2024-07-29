import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoos/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to Home Page!'),
      ),
    );
  }
}
