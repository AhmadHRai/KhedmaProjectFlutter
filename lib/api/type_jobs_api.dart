import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../language/app_words.dart';
import '../models/type_jobs_model.dart';
import '../models/user_job_model.dart';
import '../utils/colors.dart';

class Api {
  static var client = http.Client();

  Future<List<TypeJobsModel>> getTypeJobs() async {
    var response =
        await client.get(Uri.parse( AppWords.baseUri + AppWords.getCategory));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return typeJobsModelFromJson(jsonString);
    } else {
      return throw Get.snackbar(
          "Error bringing worker's data", "Please check connection!",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }

  // Future<List<JobsModel>> allCategory(String? categoryId) async {
  //   var response = await client.get(
  //       Uri.parse(AppWords.baseUri + AppWords.getUserData + categoryId!));
  //
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     return jobsModelFromJson(jsonString);
  //   } else {
  //     return throw Get.snackbar(
  //         "Error bringing worker's data", "Please check connection",
  //         backgroundColor: AppColors.icoColor2, colorText: Colors.white);
  //   }
  // }
}


