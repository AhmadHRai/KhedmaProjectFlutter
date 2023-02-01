import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khdma/api/user_api.dart';

import '../api/job_request_api.dart';
import '../models/job_request.dart';
import '../utils/colors.dart';

class JobRequestController extends GetxController{
  var isLoading = true.obs;
  var jobRequestList = <JobRequest>[].obs;

  @override
  void onInit() {
    getJobRequest();
    super.onInit();
  }

  void getJobRequest() async {
    var typeJobs = await ApiJobRequest().getJobRequests();
    if (typeJobs.isNotEmpty) {
      isLoading(false);
      jobRequestList.addAll(typeJobs);
    } else {
      isLoading(true);
      Get.snackbar(
          "Check the Internet ", "Please check the internet connection",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }
}