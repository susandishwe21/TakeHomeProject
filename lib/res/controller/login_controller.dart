import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/value.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  login() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      Get.toNamed(Nav.home);
      debugPrint("User : ${userCredential.user?.isAnonymous ?? false} ");
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
