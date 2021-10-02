import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? getCurrentUser();
  Future<String> emailSignUp({
    required String email,
    required String password,
  });
  Future<String> emailLogIn({
    required String email,
    required String password,
  });
  Future<String> sendPasswordResetEmail({required String email});
  Future<String> googleSignIn();
  Future<String> facebookSignIn();
  Future<String> appleSignIn();
  Future<void> signOut();
}
