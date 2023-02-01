import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khdma/controllers/home_controller.dart';
import '../../utils/colors.dart';
import '../about_us/about_us.dart';
import '../auth/my_profile.dart';
import '../auth/sign_in_page.dart';
import 'jobs_page.dart';

import '../../vars.dart' as v;

class HomePage extends StatefulWidget {
  static const id = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  HomeController homeController = Get.put(HomeController());

  List pages = [
    JobsPage(),
    (v.userData.length == 0)? SignInPage(): MyProfile(),
    const AboutUs(),

  ];
  void onTapNav(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    v.userData = jsonDecode(GetStorage().read("user")??"{}");
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: pages[controller.selectIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.orange,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            currentIndex: controller.selectIndex,
            onTap: (int i){
              controller.changeSelectIndex(i);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ("Home")),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ("History")),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: ("Cart")),
            ],
          ),
        );
      }
    );
  }
}
