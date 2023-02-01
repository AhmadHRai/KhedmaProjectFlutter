import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/type_jobs_controller.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../jobs/jobs_info_page.dart';
import '../widget/carousel_slider.dart';
import '../widget/drawers.dart';
import '../widget/mediat_text.dart';

class JobsPage extends StatelessWidget {
  static const id = "/JobsPage";
  final TypeJobsController typeJobsController = Get.put(TypeJobsController());
  JobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Stack(
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
                  ),
                  const CarouselSliders(key: null),
                ],
              ),
              SizedBox(
                height: Dimensions.height20 - 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: MediatText(
                    fontWeight: FontWeight.w500,
                    text: AppWords.categories,
                    color: Colors.indigo,
                  ),
                ),
              ),
              Obx(() {
                if (typeJobsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: typeJobsController.typeJobsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            JobsInfoPage.id,
                            arguments: typeJobsController.typeJobsList[index].id
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height20,
                              left: Dimensions.width20 - 10,
                              right: Dimensions.width20 - 10),
                          padding: EdgeInsets.only(
                            bottom: Dimensions.height20 - 10,
                          ),
                          child: Column(
                            children: [
                              Padding(

                                padding: EdgeInsets.all(Dimensions.height20 - 12),
                                child: Container(
                                  height: Dimensions.height100 + 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.width20 - 10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppWords.baseUri +
                                          AppWords.getImageCategory +
                                          typeJobsController
                                              .typeJobsList[index].path!),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: Dimensions.height100),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.7),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(Dimensions.width20 - 12),
                                        child: MediatText(
                                          text: typeJobsController
                                              .typeJobsList[index].name!,
                                          // AppWords.home,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
