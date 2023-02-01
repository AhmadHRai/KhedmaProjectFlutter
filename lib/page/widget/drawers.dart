import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../about_us/about_us.dart';
import '../auth/sign_in_page.dart';
import '../auth/sign_up_page.dart';
import '../home/home_page.dart';
import '../job_requests/job_request.dart';
import '../splash/splash_page.dart';
import 'mediat_text.dart';
import '../../vars.dart' as v;

class Drawers extends StatelessWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          Container(
            height: Dimensions.height100 * 2.3,
            width: double.infinity,
            color: AppColors.mainColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.height20 - 10),
                  child: Image.asset(
                    "assets/images/logo/logowhite.png",
                    height: Dimensions.height100,
                    width: Dimensions.width100,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height20 - 10),
                  child: Image.asset(
                    "assets/images/logo/descriptionwhite.png",
                    height: Dimensions.height100,
                    width: Dimensions.width100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => Get.toNamed(HomePage.id),
            title: Padding(
              padding: EdgeInsets.all(Dimensions.width20 - 12),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: const Icon(
                      Icons.home,
                      color: AppColors.mainColor,
                    ),
                  ),
                  MediatText(
                    text: AppWords.home,
                    textAlign: TextAlign.center,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            onTap: () => Get.toNamed(AboutUs.id),
            title: Padding(
              padding: EdgeInsets.all(Dimensions.width20 - 12),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: const Icon(
                      Icons.info,
                      color: AppColors.mainColor,
                    ),
                  ),
                  MediatText(
                    text: AppWords.aboutUs,
                    textAlign: TextAlign.center,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              if (v.userData.length != 0)
              {
                Get.toNamed(JobRequest.id);
              } else {
                Fluttertoast.showToast(
                  msg: "You must be login",
                  backgroundColor: Colors.amber,
                );
                Get.toNamed(SignInPage.id);
              }
            },
            title: Padding(
              padding: EdgeInsets.all(Dimensions.width20 - 12),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: const Icon(
                      Icons.track_changes,
                      color: AppColors.mainColor,
                    ),
                  ),
                  MediatText(
                    text: AppWords.jobRequest,
                    textAlign: TextAlign.center,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            onTap: () async {
              if (v.userData.length != 0)
              {
                GetStorage().write("user", null);
                Get.offAll(() => SplashPage());
                Fluttertoast.showToast(msg: "Log out successfully");
              } else {
                Fluttertoast.showToast(
                  msg: "You must be login",
                  backgroundColor: Colors.amber,
                );
                Get.back();
              }
            },
            title: Padding(
              padding: EdgeInsets.all(Dimensions.width20 - 12),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: const Icon(
                      Icons.output_outlined,
                      color: AppColors.mainColor,
                    ),
                  ),
                  MediatText(
                    text: AppWords.logOut,
                    textAlign: TextAlign.center,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
