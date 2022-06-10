import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';
import 'package:take_home_app/res/controller/login_controller.dart';
import 'package:take_home_app/res/value.dart';
import 'package:take_home_app/screen/screen_discover.dart';
import 'package:take_home_app/screen/screen_launch.dart';
import 'package:take_home_app/screen/screen_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    Get.put(DiscoverController());
    Get.put(LoginController());
    MediaQueryData windowData =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    windowData = windowData.copyWith(
      textScaleFactor: 1.0,
    );
    return MediaQuery(
      data: windowData,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color(0xffff8f00ff),
              ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
        ),
        initialRoute: Nav.splash,
        getPages: [
          GetPage(
            name: Nav.login,
            page: () => const LoginScreen(),
          ),
          GetPage(
            name: Nav.home,
            page: () => const DiscoverScreen(),
          ),
          GetPage(
            name: Nav.splash,
            page: () => const LaunchScreen(),
          )
        ],
      ),
    );
  }
}
