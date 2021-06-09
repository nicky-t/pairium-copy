import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants.dart';
import '../custom_exception.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  User? getCurrentUser();
  Future<String> emailSignUp({required String email, required String password});
  Future<String> emailLogIn({required String email, required String password});
  Future<String> googleSignIn();
  Future<String> facebookSignIn();
  Future<void> signOut();
}

class AuthRepository implements BaseAuthRepository {
  AuthRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> emailSignUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return kSuccessCode;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        return 'パスワードは６文字以上で設定してください。';
      } else if (e.code == 'email-already-in-use') {
        return 'このメールアドレスはすでに登録済みです。';
      } else {
        return 'ログインに失敗しました。';
      }
    } on Exception catch (e) {
      print(e);
      return 'ログインに失敗しました。';
    }
  }

  @override
  Future<String> emailLogIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return kSuccessCode;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        return 'ログインに失敗しました：　パスワードは６文字以上です。';
      } else if (e.code == 'account-exists-with-different-credential') {
        final userSignInMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(e.email ?? '');

        if (userSignInMethods.first == 'google.com') {
          return '以前Googleでログインしています。Googleでのログインをお試しください。';
        } else if (userSignInMethods.first == 'facebook.com') {
          return '以前Facebookでログインしています。Facebookでのログインをお試しください。';
        } else {
          return '一度別のログイン方法でログインしています。\n別のログイン方法でお試しください。';
        }
      } else {
        return 'ログインに失敗しました： パスワードが間違っているか、'
            '以前に別のログイン方法でログインしてをいないかご確認ください。';
      }
    } on Exception catch (e) {
      print(e);
      return 'ログインに失敗しました。';
    }
  }

  @override
  Future<String> googleSignIn() async {
    try {
      final signinAccount = await GoogleSignIn().signIn();
      if (signinAccount == null) return kCancelCode;

      final auth = await signinAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return kSuccessCode;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'account-exists-with-different-credential') {
        final userSignInMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(e.email ?? '');
        if (userSignInMethods.first == 'facebook.com') {
          return '以前Facebookでログインしています。Facebookでのログインをお試しください。';
        } else if (userSignInMethods.first == 'password') {
          return '以前emailでログインしています。emailでのログインをお試しください。';
        } else {
          return '一度別のログイン方法でログインしています。\n別のログイン方法でお試しください。';
        }
      } else {
        return 'ログインに失敗しました： パスワードが間違っているか、'
            '以前に別のログイン方法でログインしてをいないかご確認ください。';
      }
    } on Exception catch (e) {
      print(e);
      return 'ログインに失敗しました。';
    }
  }

  @override
  Future<String> facebookSignIn() async {
    try {
      final result = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(
          result.accessToken!.token,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        print(result.message);
        if (result.message.toString() ==
            'User has cancelled login with facebook') {
          return kCancelCode;
        } else {
          return 'ログインに失敗しました';
        }
      }
      return kSuccessCode;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'account-exists-with-different-credential') {
        final userSignInMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(e.email ?? '');
        print(userSignInMethods.first);
        if (userSignInMethods.first == 'google.com') {
          return '以前Googleでログインしています。Googleでのログインをお試しください。';
        } else if (userSignInMethods.first == 'password') {
          return '以前emailでログインしています。emailでのログインをお試しください。';
        } else {
          return '一度別のログイン方法でログインしています。\n別のログイン方法でお試しください。';
        }
      }
      return 'ログインに失敗しました';
    } on Exception catch (e) {
      print(e);
      return 'ログインに失敗しました。';
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
