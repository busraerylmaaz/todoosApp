import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Kullanıcı oluştur ve Firestore'a ekle
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
    } catch (e) {
      print('Error creating user: $e');
      throw Exception('User creation failed');
    }
  }

  // Kullanıcı girişi
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      throw Exception('Sign in failed');
    }
  }

  // Kullanıcı çıkışı
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Sign out failed');
    }
  }

  // Kullanıcı bilgilerini güncelle
  Future<void> updateUser({
    required String userId,
    required String fullName,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fullName': fullName,
      });
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('User update failed');
    }
  }

  // Kullanıcı bilgilerini getir
  Future<DocumentSnapshot> getUser(String userId) async {
    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Get user failed');
    }
  }

  // Kullanıcıyı sil
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw Exception('User deletion failed');
    }
  }
}