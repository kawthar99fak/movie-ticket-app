import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/pages/Home_Screen.dart';
import 'package:movie/pages/login_screen.dart';
import 'package:movie/utils/mytheme.dart';

class Authcontroller extends GetxController {
  static Authcontroller instance = Get.find();
  late Rx<User?> _user;
  User? get user => _user.value;
  bool isLoging = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(Duration(seconds: isLoging ? 0 : 2), () {
      if (user == null) {
        isLoging = false;
        update();
        Get.offAll(() => const LoginScreen());
      } else {
        isLoging = true;
        update();
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  void registerUser(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      getErrorSnakeBar("Account creating failed", e);
    }
  }

  void login(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      getErrorSnakeBar("Login failed", e);
    }
  }

  void googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    isLoging = true;
    update();
    try {
      googleSignIn.disconnect();
    } catch (e) {}
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleSignInAccount.authentication;
        final crendentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await auth.signInWithCredential(crendentials);
        getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
      }
    } on FirebaseAuthException catch (e) {
      getErrorSnakeBar("Google Login Failed", e);
    } on PlatformException catch (e) {
      getErrorSnakeBar("Google Login Failed", e);
    }
  }

  getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyTheme.greenTextColor,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getErrorSnakeBar(String message, _) {
    Get.snackbar("Error", "$message\n${_.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: MyTheme.redBorder,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  void forgorPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      getSuccessSnackBar("Reset mail sent successfully. Check mail!");
    } on FirebaseAuthException catch (e) {
      getErrorSnakeBar("Error", e);
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  getErrorSnackBarNew(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyTheme.redTextColor,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}
