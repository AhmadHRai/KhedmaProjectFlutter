import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../language/app_words.dart';
import '../models/job_request.dart';
import '../utils/colors.dart';

class ApiJobRequest {
  static var client = http.Client();

  Future<List<JobRequest>> getJobRequests() async {
    var response =
    await client.get(Uri.parse( AppWords.baseUri + AppWords.getJobRequest));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return jobRequestFromJson(jsonString);
    } else {
      return throw Get.snackbar(
          "Error bringing worker's data", "Please check connection!",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }
}


