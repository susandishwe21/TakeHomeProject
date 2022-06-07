import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/value.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Text(
          "Continue without Signing In",
          style: Theme.of(context).textTheme.headline5,
        ),
        onPressed: () async {
          Get.toNamed(Nav.home);
        },
      ),
    );
  }
}
