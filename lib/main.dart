import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanalysis/Config/string.dart';
import 'package:semanalysis/Config/theme.dart';
import 'package:semanalysis/Pages/DesktopHomePage/desktop_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        title: mainAppName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const DesktopHomeScreen(),
      
    );
  }
}
