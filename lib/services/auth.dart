import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<User> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;

    return user!.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user!.uid;
  }

  @override
  Future<User> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser!;
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    User user = await _firebaseAuth.currentUser!;
    return user.emailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    User user = await _firebaseAuth.currentUser!;

    user.sendEmailVerification();
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
