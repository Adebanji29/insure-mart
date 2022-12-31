import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String title,
    required String firstname,
    required String lastname,
  });
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFaceBook();
  Future<User?> signInAnonymously();
}

class AuthService implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  String authErrorMsg = '';
  CollectionReference dbRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(userCredential.user!.uid);
      // UserService().userProfile();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains(
              'There is no user record corresponding to this identifier') ||
          e.message!.contains(
              'The password is invalid or the user does not have a password')) {
        authErrorMsg = 'Invalid E-mail or Password';
      } else if (e.message!.contains('An internal error')) {
        authErrorMsg = 'An internal error occurred.\nPlease try again';
      } else if (e.code == 'user-not-found') {
        authErrorMsg = 'No user found for that email.';
      } else if (e.message!.contains(
          'A network error (such as timeout, interrupted connection or unreachable host)')) {
        authErrorMsg = 'network error';
      } else {
        authErrorMsg = e.message!;
        log(authErrorMsg);
      }
    }
    return null;
  }

  @override
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String title,
    required String firstname,
    required String lastname,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        dbRef.doc(user.uid).set(
              UserModel(
                uid: user.uid,
                firstname: firstname,
                lastname: lastname,
                email: email,
                title: title,
                gender: '',
                dob: '',
                hAddress: '',
                imgUrl: '',
              ).toJson(),
            );
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains('An internal error')) {
        authErrorMsg = 'An internal error occurred.\nPlease try again';
      } else if (e.message!.contains(
          'A network error (such as timeout, interrupted connection or unreachable host)')) {
        authErrorMsg = 'network error';
      } else if (e.code == 'weak-password') {
        authErrorMsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        authErrorMsg = 'The account already exists for that email.';
      } else {
        authErrorMsg = e.message!;
        log(authErrorMsg);
      }
    }
    return null;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Mising Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    return null;
  }

  @override
  Future<User?> signInWithFaceBook() async {
    final fb = FacebookLogin();
    final FacebookLoginResult response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken!.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error!.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final facebookLogin = FacebookLogin();
      await facebookLogin.logOut();
      await _firebaseAuth.signOut();
      UserModel().dispose();
      // user = null;
    } on FirebaseAuthException catch (e) {
      authErrorMsg = e.message!;
    } catch (e) {
      log(e.toString());
    }
  }
}
