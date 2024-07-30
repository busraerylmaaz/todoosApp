import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoos/controller/auth_controller.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final AuthController authController = Get.find();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  var isLogin = true.obs;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E0E9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1), 
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 109,
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => Text(
                  isLogin.value ? "Sign In" : "Sign Up",
                  style: TextStyle(
                    color: Colors.pink[900],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(height: 20),
                Obx(() => !isLogin.value ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ) : SizedBox.shrink()),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => authController.errorMessage.isEmpty
                    ? const SizedBox.shrink()
                    : Text(
                        authController.errorMessage.value,
                        style: TextStyle(color: Colors.pink[900]),
                      )),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isValidEmail(emailController.text)) {
                        authController.errorMessage.value = "Invalid email format";
                      } else if (passwordController.text.length < 8) {
                        authController.errorMessage.value = "Password must be at least 8 characters";
                      } else {
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEAA6CA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Obx(() => Text(
                      isLogin.value ? "Login" : "Register",
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    isLogin.value = !isLogin.value;
                  },
                  child: Obx(() => Text(
                    isLogin.value
                        ? "Don't have an account? Sign up."
                        : "Already have an account? Sign in.",
                    style: TextStyle(color: Colors.pink[900]),
                  )),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFFEAA6CA)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google_logo.png', height: 24),
                        SizedBox(width: 10),
                        Text(
                          "Sign In with Google",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.pink[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
