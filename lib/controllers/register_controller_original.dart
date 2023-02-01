import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../api/auth_api.dart';
import '../page/auth/sign_in_page.dart';
import '../utils/colors.dart';

class RegisterController extends GetxController {

  var selectedRoleId = "0".obs;

  final isVisible = false.obs;

  var isLoading = false.obs;

  var isProfileImagePath = false.obs;
  var profilePicPath = "".obs;
  var profileImageBase64;

  var selectJob = "".obs;
  var role = "".obs;

  onChangeRole(var role) {
    role.value = role;
  }

  onChangeJob(var job) {
    selectJob.value = job;
  }

  final registerFormKey = GlobalKey<FormState>();


  // final storage = const FlutterSecureStorage();
  late TextEditingController nameController,
      emailController,
      addressController,
      passwordController,
      phoneController;
  RxString roll = "".obs;
  RxString type_job_id = "".obs;
  String name = '', email = '', address = '', password = '', phone = '';

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    roll = RxString(roll.value);
    type_job_id = RxString(type_job_id.value);
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "This is not Email";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 8) {
      return "At less 8 letter";
    } else {
      return null;
    }
  }

  String? validatePhone(String value) {
    if (value.length == 9) {
      return "At less 9 Number";
    } else {
      return null;
    }
  }

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProfileImagePath.value = true;

    final bytes = File(profilePicPath.value).readAsBytesSync();
    profileImageBase64 = base64.encode(bytes);
  }

  doRegister() async {
    bool isValidate = registerFormKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      try {
        var data = AuthApi.register(
          name: nameController.text,
          password: passwordController.text,
          email: emailController.text,
          phone: phoneController.text,
          address: addressController.text,
          role: roll.value,
          typeJobId: type_job_id.value,
          // path: isProfileImagePath,
        );
        if (data != null) {
          registerFormKey.currentState?.save();
          Get.toNamed(SignInPage.id);
        } else {
          Get.snackbar(
            "Register",
            "Some think error",
            backgroundColor: AppColors.icoColor2,
            colorText: Colors.white,
          );
        }
      } finally {
        isLoading(false);
      }
    }
  }

  PickedFile? _pickedFile;
  PickedFile? get pickedFile=> _pickedFile;
  final _picker = ImagePicker();

  Future<void> pickedImage() async{
    _pickedFile= await _picker.getImage(source:ImageSource.gallery);
    update();

  }
}
