import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khdma/controllers/home_controller.dart';
import '../../controllers/user_job_controller.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../details/person_details_page.dart';
import '../widget/drawers.dart';
import '../widget/main_text.dart';
import '../widget/mediat_text.dart';
import '../widget/small_text.dart';
import '../../vars.dart' as v;

class JobsInfoPage extends StatelessWidget {
  static const id = "/JobsInfoPage";
  final UserJobsController userJobsController = Get.put(UserJobsController());
  JobsInfoPage({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.textColor,
        appBar: AppBar(
          elevation: 0.0,
          title: MediatText(
            text: AppWords.appName,
            color: Colors.white,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        drawer: const Drawers(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Dimensions.height100 + 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Dimensions.width45 + 60),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: MediatText(
                          fontWeight: FontWeight.w500,
                          text: AppWords.appName,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SmallText(
                          fontWeight: FontWeight.w500,
                          text: "Are you search some one do job for you??",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SmallText(
                          fontWeight: FontWeight.w500,
                          text: "We have easy solution to you.",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (userJobsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userJobsController.userJobsList.length,
                    // itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (v.userData.length == 0) {
                            Fluttertoast.showToast(
                              msg: "Must login",
                              backgroundColor: Colors.amber,
                            );
                            homeController.changeSelectIndex(1);
                            Get.back();
                          } else {
                            await Get.to(
                              () => PersonDetailsPage(
                                jobsModel:
                                    userJobsController.userJobsList[index],
                              ),
                            );
                            userJobsController.getUserJobs();
                          }
                        },
                        child: Card(
                          shadowColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   height: Dimensions.height100 + 50,
                                //   width: Dimensions.width100 + 20,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(
                                //         Dimensions.radius20),
                                //     color: Colors.white12,
                                //     image: const DecorationImage(
                                //       fit: BoxFit.cover,
                                //       image: AssetImage(
                                //           "assets/images/electrical.jpg"),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 80,
                                  width: 100,
                                  child: Image.network(
                                    "${v.storageLink}${userJobsController.userJobsList[index].path!}",
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, obj, st) {
                                      return Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      );
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Column(
                                  children: [

                                    SmallText(
                                        text: userJobsController
                                            .userJobsList[index].name!),
                                    SmallText(text: userJobsController.userJobsList[index].address!),
                                    SmallText(
                                      text: "${(userJobsController.userJobsList[index].booking == '1')? "booked": ""}",
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimensions.width45),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width45 - 15,
                                      ),
                                      MediatText(
                                          text: userJobsController
                                              .userJobsList[index].rating!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ));
  }
}
