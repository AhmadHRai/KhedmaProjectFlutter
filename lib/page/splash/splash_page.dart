import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../home/home_page.dart';
import '../widget/main_text.dart';
import '../../vars.dart' as v;

class SplashPage extends StatefulWidget {
  static const id = "/SplashPage";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    v.userData = jsonDecode(GetStorage().read("user") ?? "{}");

    Future.delayed(const Duration(seconds: 3), () async {
      Get.to(
        HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo/logo.png",
              height: Dimensions.height100 * 2,
              width: Dimensions.width100 * 2,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo/description.png",
              height: Dimensions.height100 * 2,
              width: Dimensions.width100 * 2,
            ),
          ),
          const MainText(
            text: AppWords.appName,
            textAlign: TextAlign.center,
            color: AppColors.mainColor,
          ),
        ],
      ),
    );
  }
}
