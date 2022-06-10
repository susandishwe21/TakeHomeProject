import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/instance_manager.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';
import 'package:take_home_app/res/controller/login_controller.dart';
import 'package:take_home_app/res/value.dart';
import 'package:take_home_app/screen/screen_discover.dart';
import 'package:take_home_app/screen/screen_login.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var dateTime = DateTime.parse(DateTime.now().toString());
        Get.find<DiscoverController>().getAppointmentsSlot(dateTime);
        Get.find<DiscoverController>().getAllPrice();
      },
    );
    var login = Get.find<LoginController>();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SplashScreenView(
            navigateRoute: login.isLoggedIn.value
                ? const DiscoverScreen()
                : const LoginScreen(),
            duration: 4000,
            imageSize: 550,
            //imageSrc: "assets/logo.png",
            text: "Loading...",
            textType: TextType.ColorizeAnimationText,
            textStyle: const TextStyle(
              fontSize: 28.0,
            ),
            colors: const [
              Colors.purple,
              Colors.blue,
              Colors.yellow,
              Colors.red,
            ],
            backgroundColor: Colors.white,
          ),
          Positioned(
            bottom: 300,
            left: 180,
            right: 180,
            child: SpinKitChasingDots(
              color: TestColor().primaryColor,
              size: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
