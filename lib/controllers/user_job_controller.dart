import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/user_api.dart';
import '../models/user_job_model.dart';
import '../utils/colors.dart';

class UserJobsController extends GetxController {
  var isLoading = true.obs;
  var userJobsList = <JobsModel>[].obs;
  var likeMap = {}.obs;
  int? jobId;

  var chooseBooking = "".obs;

  onSelectedBooking(var booking) {
    chooseBooking.value = booking;
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is int) {
      jobId = Get.arguments;
    } else {
      Get.back();
      Future.delayed(const Duration(seconds: 1)).then((value) => Get.snackbar(
          "Error ", "No Job Id",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white));
    }
    getUserJobs();
    super.onInit();
  }

  getUserJobs() async {
    try {
      var userJobs = await ApiUserJob().getUserJob(jobId!);
      if (userJobs != null) {
        isLoading(false);
        userJobsList.assignAll(userJobs);

      } else {
        isLoading(true);
        Get.snackbar(
            "Check the Internet ", "Please check the internet connection",
            backgroundColor: AppColors.icoColor2, colorText: Colors.white);
      }
    }catch(err){
      print("err getUserJobs: ${err}");
    }
  }
}
