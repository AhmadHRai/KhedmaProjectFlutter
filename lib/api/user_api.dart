import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../language/app_words.dart';
import '../models/user_job_model.dart';
import '../utils/colors.dart';

class ApiUserJob {
  static var client = http.Client();

  Future<List<JobsModel>> getUserJob(int jobId) async {
    var response =
        await client.get(Uri.parse(AppWords.baseUri + AppWords.getUserData+"$jobId"));

    if (response.statusCode == 200) {
      var jsonString = response.body;

      print("TRes");
      return jobsModelFromJson(jsonString);
    } else {
      return throw Get.snackbar(
          "Error bringing worker's data", "Please check connection",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }
}
//pub.dev logger