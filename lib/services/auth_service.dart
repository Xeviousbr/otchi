import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //efetua o login
  static Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  static Stream<bool> estaLogado() => FirebaseAuth.instance
      .authStateChanges()
      .map((user) => user != null && !user.isAnonymous);

  //sai da conta
  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<bool> cadastraUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({});

      return true;
    } catch (_) {
      return false;
    }
  }
}
