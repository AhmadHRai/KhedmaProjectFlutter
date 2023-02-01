import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/auth_api.dart';
import '../utils/colors.dart';

class LoginController extends GetxController {
  var isDataReadingCompleted= false.obs;

  var isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  List<String> getAllUser =[];
  late TextEditingController emailController, passwordController;
  String email = '', password = '';

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  doLogin() async {
    bool isValidate = loginFormKey.currentState!.validate();

    if (isValidate) {
      isLoading(true);
      try {
        var data = AuthApi.login(
          password: passwordController.text,
          email: emailController.text,
        );
        if (data != null) {

          loginFormKey.currentState!.save();
        } else {
          Get.snackbar("Login", "Some think error",
              backgroundColor: AppColors.icoColor2, colorText: Colors.white);
        }
      } finally {
        isLoading(false);
      }
    }
  }
}
