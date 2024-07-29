import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoos/pages/home_page.dart';
import 'package:todoos/pages/login_register_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  var user = Rx<User?>(null);
  var errorMessage = ''.obs;

  @override
  void onReady() {
    super.onReady();
    user.bindStream(_firebaseAuth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginRegisterPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  Future<void> createUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      errorMessage.value = '';
      Get.offAll(() => HomePage());
    } catch (e) {
      errorMessage.value = 'User creation failed: $e';
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      errorMessage.value = '';
      Get.offAll(() => HomePage());
    } catch (e) {
      errorMessage.value = 'Sign in failed: $e';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut(); 
      Get.offAll(() => const LoginRegisterPage());
    } catch (e) {
      errorMessage.value = 'Sign out failed: $e';
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut(); 
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return; 
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'fullName': user.displayName,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      errorMessage.value = '';
      Get.offAll(() => HomePage());
    } catch (e) {
      errorMessage.value = 'Google sign in failed: $e';
    }
  }
}
