import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoos/controller/auth_controller.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    var isLogin = true.obs;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            Obx(() => isLogin.value
                ? const SizedBox.shrink()
                : TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                  )),
            Obx(() => authController.errorMessage.isEmpty
                ? const SizedBox.shrink()
                : Text(authController.errorMessage.value)),
            ElevatedButton(
              onPressed: () {
                if (isLogin.value) {
                  authController.signIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                } else {
                  authController.createUser(
                    email: emailController.text,
                    password: passwordController.text,
                    fullName: fullNameController.text,
                  );
                }
              },
              child: Obx(() => Text(isLogin.value ? "Login" : "Register")),
            ),
            GestureDetector(
              onTap: () {
                isLogin.value = !isLogin.value;
              },
              child: Obx(() => Text(isLogin.value
                  ? "Henüz bir hesabın yok mu? Tıkla."
                  : "Zaten bir hesabın var mı? Giriş yap.")),
            ),
          ],
        ),
      ),
    );
  }
}
