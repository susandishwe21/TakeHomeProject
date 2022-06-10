import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:take_home_app/res/value.dart';

class LoginController extends GetxController {
  //declare variable for already login or isn't login for user
  RxBool isLoggedIn = false.obs;
  //local storage
  var box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    box.writeIfNull(Keys.isLoggedIn, false);
    isLoggedIn.value = box.read(Keys.isLoggedIn);
  }

  //Anonymous Sign In with firebase
  login() async {
    try {
      isLoggedIn.value = true;
      update();
      box.write(Keys.isLoggedIn, true);
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      Get.offAllNamed(Nav.home);
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

  //Sign Out
  logout() async {
    isLoggedIn.value = false;
    update();
    box.write(Keys.isLoggedIn, false);
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Nav.login);
  }
}
