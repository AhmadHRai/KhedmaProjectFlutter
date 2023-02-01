import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../language/app_words.dart';
import '../models/user_model.dart';
import '../utils/colors.dart';

class AuthApi {
  static var client = http.Client();

  static register({
    required name,
    required email,
    required password,
    required phone,
    required address,
    path,
    typeJobId,
    role,
  }) async {
    var response = await client.post(
      Uri.parse(AppWords.baseUri + AppWords.createUser),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
        "path": path,
        "typeJobId": typeJobId,
        "role": role,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonString = response.body;
      var user = userModelFromJson(jsonString);
      return user;
    } else {
      Get.snackbar("Please", "You in Register !",
          backgroundColor: AppColors.icoColor2, colorText: Colors.white);
    }
  }

  static login({
    required email,
    required password,
  }) async {
    var response = await client.post(
      Uri.parse(AppWords.baseUri + AppWords.createUser),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<dynamic, dynamic>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonString = response.body;
      var user = userModelFromJson(jsonString);
      return user;
    } else {
      return null;
    }
  }
}
