import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khdma/page/auth/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/myapi.dart';
import '../../controllers/login_controller_original.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../splash/splash_page.dart';
import '../widget/app_text_field.dart';
import '../widget/main_text.dart';

class SignInPage extends StatelessWidget {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  final LoginController loginController = Get.put(LoginController());

  static const id = "/SignInPage";
  SignInPage({Key? key}) : super(key: key);

  MyApi myApi = MyApi();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: loginController.loginFormKey,
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                height: Dimensions.screenHeight * 0.25,
                padding: EdgeInsets.all(Dimensions.height45 + 15),
                child: Center(
                  child: Image.asset("assets/images/logo/logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize:
                              Dimensions.font20 * 3 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                keyboardKey: TextInputType.emailAddress,
                textController: loginController.emailController,
                hintText: "Email",
                icon: Icons.email,
                iconColor: AppColors.mainColor,
                hintTextColor: AppColors.icoColor2,
                valueChange: () {},
                erroeText: "You @",
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                  keyboardKey: TextInputType.visiblePassword,
                  textController: loginController.passwordController,
                  hintText: "Password",
                  obscureText: true,
                  icon: Icons.password_sharp,
                  iconColor: AppColors.mainColor,
                  hintTextColor: AppColors.icoColor2,
                  valueChange: () {},
                  erroeText: "You 8"),
              SizedBox(
                height: Dimensions.height20 + 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Sign in your account",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),

              Builder(
                  builder: (context) {
                    bool isUploading = false;
                    return StatefulBuilder(
                        builder: (context, setStateInternal) {
                          return Visibility(
                            visible: !isUploading,
                            replacement: Container(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(),
                            ),
                            child: GestureDetector(
                              onTap: () async {

                                if(loginController.loginFormKey.currentState!.validate() == true){
                                  isUploading = true;
                                  setStateInternal((){});

                                  try {
                                    // login ______________________________
                                    Map? response = await myApi.postRequest(
                                      apiName: "userlogin",
                                      params: {
                                        'email': "${loginController.emailController.text}",
                                        'password': "${loginController.passwordController.text}",
                                      },
                                    );
                                    if (response != null) {
                                      String user = jsonEncode(response);
                                      print("user: ${user}");
                                      await GetStorage().write("user", "${user}");
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Failed in login",
                                          backgroundColor: Colors.red
                                      );
                                    }
                                    isUploading = false;
                                    setStateInternal(() {});
                                    await Future.delayed(Duration(milliseconds: 250));
                                    Get.offAll(() => SplashPage());
                                    // end login ____________________________________
                                  }catch(err){
                                    Fluttertoast.showToast(
                                        msg: "Failed in login",
                                        backgroundColor: Colors.red
                                    );
                                  }
                                }
                                isUploading = false;
                                setStateInternal(() {});
                              },
                              child: Container(
                                width: Dimensions.screenWidth / 2,
                                height: Dimensions.screenHeight / 15,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.radius5),
                                    color: AppColors.mainColor),
                                child: Center(
                                  child: MainText(
                                    text: "Login",
                                    size: Dimensions.font20 + Dimensions.font20 / 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
              ),

              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              RichText(
                text: TextSpan(
                  text: "Don\'t an account? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpPage(),
                            transition: Transition.fade),
                      text: "Create",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
