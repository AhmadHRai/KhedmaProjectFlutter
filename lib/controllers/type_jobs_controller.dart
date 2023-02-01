import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/type_jobs_api.dart';
import '../models/type_jobs_model.dart';
import '../models/user_job_model.dart';
import '../utils/colors.dart';

class TypeJobsController extends GetxController {
  var isLoading = true.obs;
  var isLoadingJob = true.obs;

  var typeJobsList = <TypeJobsModel>[].obs;
  List<String> typeJobsListString = [];
  var jobsList = <JobsModel>[].obs;

  @override
  void onInit() {
    getTypeJobs();
    super.onInit();
  }

  void getTypeJobs() async {
    var typeJobs = await Api().getTypeJobs();
    if (typeJobs.isNotEmpty) {
      isLoading(false);
      typeJobsList.addAll(typeJobs);
      for (var element in typeJobsList) {
        typeJobsListString.add(element.name ?? '');
      }
      update();
    } else {
      isLoading(true);
      Get.snackbar(
          "Check the Internet ", "Please check the internet connection",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }
}
