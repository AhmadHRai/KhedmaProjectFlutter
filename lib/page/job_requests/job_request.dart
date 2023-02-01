import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khdma/page/widget/drawers.dart';
import '../../api/myapi.dart';
import '../../controllers/job_request_controller.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widget/main_text.dart';
import '../widget/mediat_text.dart';
import '../widget/small_text.dart';
import '../../vars.dart' as v;
class JobRequest extends StatelessWidget {
  static const id = "/JobRequest";

  JobRequest({Key? key}) : super(key: key);

  final JobRequestController jobRequestController = Get.put(JobRequestController());

  MyApi myApi = MyApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: MediatText(
          text: "Job Request",
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      drawer: Drawers(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Dimensions.height100 + 0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height100 - 20),
                  child: const Center(
                    child: MainText(
                      text: AppWords.aboutUs,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Container(
                  height: Dimensions.height100 + 0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.width45),
                      topLeft: Radius.circular(Dimensions.width45),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.height45 - 25),
                    child: Image.asset("assets/images/logo/logo.png"),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height20 - 12),
              child: Obx(() {
                if (jobRequestController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: jobRequestController.jobRequestList.length,
                    itemBuilder: (context, index) {
                      if(
                        jobRequestController.jobRequestList[index].userIdC == "${v.userData['id']}" ||
                        jobRequestController.jobRequestList[index].userIdW == "${v.userData['id']}" ||
                        v.userData['role'] == "1"
                      ) {
                        return Card(
                        color:AppColors.textColor,
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.width20 - 10,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallText(text: jobRequestController.jobRequestList[index].title??""),
                                      SizedBox(height: Dimensions.height20 - 10,),
                                      SmallText(text: jobRequestController.jobRequestList[index].dateStart),
                                      SizedBox(height: Dimensions.height20 - 10,),
                                      SmallText(text: jobRequestController.jobRequestList[index].dateEnd),
                                      SizedBox(height: Dimensions.height20 - 10,),
                                      SmallText(text: jobRequestController.jobRequestList[index].price,),
                                      SizedBox(height: Dimensions.height20 - 10,),
                                      if (jobRequestController.jobRequestList[index].status == "1")
                                        SmallText(text: "تم الموافق على العمل" , color: AppColors.mainColor,),
                                      if (jobRequestController.jobRequestList[index].status == "0")
                                        SmallText(text: "لم يتم الموافقة" , color: Colors.redAccent,),
                                    ],
                                  ),
                                ),
                              ),
                              if( jobRequestController.jobRequestList[index].userIdW == "${v.userData['id']}" || v.userData['role'] == "1")
                                Builder(
                                builder: (context) {
                                  bool isUploading = false;
                                  return StatefulBuilder(
                                      builder: (context, setStateInternal) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .only(end: 22),
                                          child: Visibility(
                                            visible: !isUploading,
                                            replacement: Column(
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                            child: Visibility(
                                                visible: (jobRequestController
                                                    .jobRequestList[index]
                                                    .status == "0")
                                                    ? true
                                                    : false,
                                                replacement: ElevatedButton(
                                                  onPressed: null,
                                                  child: Text("Done"),
                                                ),
                                                child: ElevatedButton(
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    primary: AppColors
                                                        .icoColor2,
                                                  ),
                                                  onPressed: () async {
                                                    setStateInternal(() {
                                                      isUploading = true;
                                                    });

                                                    await myApi.postRequest(
                                                        apiName: "work_status",
                                                        conditionId: "${jobRequestController
                                                            .jobRequestList[index]
                                                            .id}",
                                                        params: {
                                                          "status": "1",
                                                        })?.then((value) {
                                                      if (jobRequestController
                                                          .jobRequestList[index]
                                                          .status == "0") {
                                                        jobRequestController
                                                            .jobRequestList[index]
                                                            .status = "1";
                                                      } else {
                                                        jobRequestController
                                                            .jobRequestList[index]
                                                            .status = "0";
                                                      }
                                                    }).catchError((err) {
                                                      print("err");
                                                      Fluttertoast
                                                          .showToast(
                                                          msg: "Failed Agree",
                                                          backgroundColor: Colors
                                                              .red
                                                      );
                                                    });

                                                    setStateInternal(() {
                                                      isUploading = false;
                                                    });
                                                  },
                                                  child: Text("Agree"),
                                                )
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }else{
                        return Text("");
                      }

                    }
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
