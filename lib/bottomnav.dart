import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bottomnav_controller.dart';
import 'menu/homepage.dart';
import 'menu/mylistpage.dart';
import 'menu/profilepage.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    final menus = [
      HomePage(),
      MyListPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                'English Premier League',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: menus.elementAt(controller.selectedIndex.value),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) => controller.changeIndex(index),
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt),
                  label: 'My List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          )),
    );
  }
}
