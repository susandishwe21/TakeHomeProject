import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';
import 'package:take_home_app/res/controller/login_controller.dart';
import 'package:take_home_app/res/value.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var dateTime = DateTime.parse(DateTime.now().toString());
        Get.find<DiscoverController>().getAppointmentsSlot(dateTime);
        Get.find<DiscoverController>().getAllPrice();
      },
    );
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            TestColor().primaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text(
          "Continue without Signing In",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
              ),
        ),
        onPressed: () async {
          Get.find<LoginController>().login();
        },
      ),
    );
  }
}
