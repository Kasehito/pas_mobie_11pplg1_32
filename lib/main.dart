import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/loginpage.dart';
import 'bottomnav.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Premier League',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/bottomnav', page: () => const BottomNav()),
      ],
    );
  }
}
