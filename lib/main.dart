import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/value.dart';
import 'package:take_home_app/screen/screen_discover.dart';
import 'package:take_home_app/screen/screen_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.cyan
          //primaryColor: Color(0xffff8f00ff),
          ),
      initialRoute: Nav.login,
      getPages: [
        GetPage(
          name: Nav.login,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: Nav.home,
          page: () => const DiscoverScreen(),
        )
      ],
    );
  }
}
