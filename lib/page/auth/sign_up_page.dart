import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khdma/page/splash/splash_page.dart';
import '../../controllers/register_controller_original.dart';
import '../../controllers/type_jobs_controller.dart';
import '../../language/app_words.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widget/app_text_field.dart';
import '../widget/main_text.dart';
import '../../funs.dart' as f;
import '../../api/myapi.dart';

class SignUpPage extends StatefulWidget {
  static const id = "/SignUpPage";

  SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final RegisterController registerController = Get.put(RegisterController());



  // path
  File? path;
  File? path_card;
  MyApi myApi = MyApi();
  int? role = 3;
  TypeJobItem? typeJobItemSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<TypeJobsController>(
          init: TypeJobsController(),
          builder: (typeJobsController) => Column(
            children: [

              // SelectPic(),
              SizedBox(height: 50,),

              // image of user _____________________________________________________
              Container(
                height: 150,
                width: 200,
                child: Builder(
                    builder: (context) {
                      bool ischoosing = false;
                      return StatefulBuilder(
                        builder: (context, setStateInternal) {
                          return (ischoosing == false)? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              elevation: 5,
                              primary: Colors.white,
                              onPrimary: Colors.black
                            ),
                            child: (path == null)?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 40,),
                                  Text("User Image", style: TextStyle(fontSize: 12),),
                                ],
                              ) :
                              ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Image.file(path!, fit: BoxFit.cover,)
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: TextButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black.withOpacity(0.2),
                                          onPrimary: Colors.white
                                      ),
                                      child: Icon(Icons.close, size: 30,),
                                      onPressed: () async {
                                        ischoosing = true;
                                        setStateInternal((){});
                                        if(path != null) {
                                          if (path!.existsSync()) {
                                            path!.deleteSync();
                                            path = null;
                                          }
                                        }
                                        ischoosing = false;
                                        setStateInternal((){});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              ischoosing = true;
                              setStateInternal((){});
                              path = await Get.defaultDialog(
                                title: "التقاط صورة",
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            iconSize: 42,
                                            icon: Icon(Icons.camera_alt, color: Colors.black,),
                                            onPressed: () async {
                                              Navigator.of(context).pop(await f.picturePicker(fromCamera: true));
                                            },
                                          ),
                                          Text("كاميرا"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            iconSize: 42,
                                            icon: Icon(
                                              Icons.image, color: Colors.black,),
                                            onPressed: () async {
                                              Navigator.of(context).pop(await f.picturePicker(fromCamera: false));
                                            },
                                          ),
                                          Text("المعرض"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ).then((value) async {
                                return value;
                              }).catchError((err){
                                return null;
                              });

                              if(path != null) {
                                print("name file: ${path!.path}, size file: ${path!.lengthSync() / (1024 * 1024)}");
                              }
                              ischoosing = false;
                              setStateInternal((){});
                            },
                          ): Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))
                              ),
                            ],
                          );
                        }
                      );
                    }
                ),
              ),
              // end image of user _____________________________________________________
              SizedBox(height: 30,),
              // image of card _____________________________________________________
              Container(
                height: 150,
                width: 200,
                child: Builder(
                    builder: (context) {
                      bool ischoosing = false;
                      return StatefulBuilder(
                        builder: (context, setStateInternal) {
                          return (ischoosing == false)? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              elevation: 5,
                              primary: Colors.white,
                              onPrimary: Colors.black
                            ),
                            child: (path_card == null)?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 40,),
                                  Text("Card Image", style: TextStyle(fontSize: 12),),
                                ],
                              ) :
                              ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Image.file(path_card!, fit: BoxFit.cover,)
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: TextButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black.withOpacity(0.2),
                                          onPrimary: Colors.white
                                      ),
                                      child: Icon(Icons.close, size: 30,),
                                      onPressed: () async {
                                        ischoosing = true;
                                        setStateInternal((){});
                                        if(path_card != null) {
                                          if (path_card!.existsSync()) {
                                            path_card!.deleteSync();
                                            path_card = null;
                                          }
                                        }
                                        ischoosing = false;
                                        setStateInternal((){});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              ischoosing = true;
                              setStateInternal((){});
                              path_card = await Get.defaultDialog(
                                title: "التقاط صورة",
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            iconSize: 42,
                                            icon: Icon(Icons.camera_alt, color: Colors.black,),
                                            onPressed: () async {
                                              Navigator.of(context).pop(await f.picturePicker(fromCamera: true));
                                            },
                                          ),
                                          Text("كاميرا"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            iconSize: 42,
                                            icon: Icon(
                                              Icons.image, color: Colors.black,),
                                            onPressed: () async {
                                              Navigator.of(context).pop(await f.picturePicker(fromCamera: false));
                                            },
                                          ),
                                          Text("المعرض"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ).then((value) async {
                                return value;
                              }).catchError((err){
                                return null;
                              });

                              if(path_card != null) {
                              }
                              ischoosing = false;
                              setStateInternal((){});
                            },
                          ): Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))
                              ),
                            ],
                          );
                        }
                      );
                    }
                ),
              ),
              // end image of card _____________________________________________________

              SizedBox(height: 30,),
              Form(
                key: registerController.registerFormKey,
                child: Column(
                  children: [
                    AppTextField(
                      textController: registerController.nameController,
                      hintText: "Full Name",
                      icon: Icons.person,
                      erroeText: AppWords.thisFidldIsRequired,
                      iconColor: AppColors.mainColor,
                      hintTextColor: AppColors.icoColor2,
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AppTextField(
                      textController: registerController.addressController,
                      hintText: "Address",
                      iconColor: AppColors.mainColor,
                      hintTextColor: AppColors.icoColor2,
                      icon: Icons.map,
                      valueChange: () {},
                      erroeText: "",
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AppTextField(
                      keyboardKey: TextInputType.emailAddress,
                      textController: registerController.emailController,
                      hintText: "Email",
                      icon: Icons.email,
                      iconColor: AppColors.mainColor,
                      hintTextColor: AppColors.icoColor2,
                      erroeText: AppWords.youMustAdd,
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AppTextField(
                        keyboardKey: TextInputType.visiblePassword,
                        obscureText: true,
                        textController: registerController.passwordController,
                        hintText: AppWords.password,
                        icon: Icons.password_sharp,
                        iconColor: AppColors.mainColor,
                        hintTextColor: AppColors.icoColor2,
                        valueChange: () {},
                        erroeText: AppWords.forPassword),
                    SizedBox(height: Dimensions.height20,),
                    AppTextField(
                      keyboardKey: TextInputType.number,
                      textController: registerController.phoneController,
                      hintText: AppWords.phone,
                      icon: Icons.phone,
                      iconColor: AppColors.mainColor,
                      hintTextColor: AppColors.icoColor2,
                      valueChange: (value) {
                        registerController.validatePhone(value);
                      },
                      erroeText: AppWords.forPhoneNumber,
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Builder(
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setStateInternal) {
                            return Container(
                              width: Get.width * 0.9,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: (role == 3)? Colors.blue[100]: Colors.transparent
                                          ),
                                          onPressed: (){
                                            role = 3;
                                            setStateInternal((){});
                                          },
                                          child: Text("Client")
                                        ),
                                      ),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        child: OutlinedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: (role == 2)? Colors.blue[100]: Colors.transparent
                                          ),
                                          onPressed: (){
                                            role = 2;
                                            setStateInternal((){});
                                          },
                                          child: Text("Worker")
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height20,),
                                  Visibility(
                                    visible: (role == 2)? true: false,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(4),
                                      elevation: 2,
                                      shadowColor: Colors.grey[200],
                                      color: Colors.white,
                                      child: DropdownSearch<TypeJobItem>(
                                        validator: (TypeJobItem? item){
                                          if(item != null){
                                            if(item.name == "" || item.name == null){
                                              return "The field is required";
                                            }
                                          }else{
                                            return "The field is required";
                                          }
                                          return null;
                                        },
                                        asyncItems: (String? filter) async {
                                          List table = await myApi.getRequest(
                                            apiName: "type_jobindex",
                                          );
                                          print("table: ${table}");
                                          await Future.delayed(Duration(milliseconds: 250));
                                          final List<TypeJobItem> items = table.asMap().map((key, value) {
                                            return MapEntry(key,
                                                TypeJobItem(
                                                  id: value['id'],
                                                  name: value['name'],
                                                ));
                                          }).values.toList();
                                          return items;
                                        },
                                        popupProps: PopupProps.modalBottomSheet(
                                            itemBuilder: (context, item, isselected){
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                                    textColor: (isselected ==true)? Colors.blue: Colors.black,
                                                    title: Text("${item.name}",),
                                                  ),
                                                  Divider(
                                                    height: 0,
                                                    color: isselected? Colors.blue: Colors.grey[300],
                                                    indent: 15,
                                                    endIndent: 15,
                                                  ),
                                                ],
                                              );
                                            },
                                            scrollbarProps: ScrollbarProps(
                                                thumbVisibility: true
                                            ),
                                            showSelectedItems: true,
                                            constraints: BoxConstraints(
                                                maxHeight: 250
                                            ),
                                            showSearchBox: true,
                                            searchFieldProps: TextFieldProps(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                                                hintText: "بحث" + " ...",
                                              ),
                                            ),
                                            emptyBuilder: (context, str){
                                              return Center(child: Text("لا توجد بيانات"));
                                            },
                                            loadingBuilder: (context, str) {
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                        ),
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            //labelText: "Menu mode",
                                            hintText: "Choose job ...",
                                            prefixIcon: IconButton(
                                              icon: Icon(Icons.work_history_outlined, color: Colors.blue,),
                                              onPressed: (){},
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              gapPadding: 0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                              borderRadius: BorderRadius.circular(4),
                                              gapPadding: 0,
                                            ),
                                          ),
                                        ),
                                        clearButtonProps: ClearButtonProps(
                                          isVisible: true,
                                          // icon: Icon(Icons.close),
                                        ),
                                        onChanged: (TypeJobItem? item) {
                                          print("item: ${item?.name}");
                                          typeJobItemSelected = item;
                                        },
                                        selectedItem: typeJobItemSelected,
                                        compareFn: (i, s) {
                                          return (i.id == s.id)? true: false;
                                        },
                                        itemAsString: (TypeJobItem? item) {
                                          return item!.name!;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        );
                      }
                    ),


                    SizedBox(height: Dimensions.height20,),
                    SizedBox(height: Dimensions.height20,),

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
                                  if(registerController.registerFormKey.currentState!.validate() == true){
                                    isUploading = true;
                                    setStateInternal((){});
                                    int? type_job_id = 0;
                                    if(typeJobItemSelected != null){
                                      type_job_id = typeJobItemSelected!.id;
                                    }
                                    await myApi.postRequest(
                                      apiName: "userstore",
                                      path: path,
                                      path_card: path_card,
                                      params: {
                                        'name': "${registerController.nameController.text}",
                                        'email': "${registerController.emailController.text}",
                                        'phone': "${registerController.phoneController.text}",
                                        'password': "${registerController.passwordController.text}",
                                        'address': "${registerController.addressController.text}",
                                        'type_job_id': "${type_job_id}",
                                        'role': "${role}"
                                      },
                                    );
                                    await Future.delayed(Duration(milliseconds: 250));
                                    try {
                                      // login ______________________________
                                      Map? response = await myApi.postRequest(
                                        apiName: "userlogin",
                                        params: {
                                          'email': "${registerController.emailController.text}",
                                          'password': "${registerController.passwordController.text}",
                                     
                                        },
                                      );
                                      if (response != null) {
                                        String user = jsonEncode(response);
                                        print("user: ${user}");
                                        await GetStorage().write(
                                            "user", "${user}");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Failed in login",
                                            backgroundColor: Colors.red
                                        );
                                      }
                                      isUploading = false;
                                      setStateInternal(() {});
                                      await Future.delayed(
                                          Duration(milliseconds: 250));
                                      Get.offAll(() => SplashPage());
                                      // end login ____________________________________
                                    }catch(err){
                                      print("err login: ${err}");
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
                                      text: "Sign Up",
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

                    SizedBox(height: Dimensions.height20 - 10,),
                    RichText(
                      text: TextSpan(
                        text: "Have an account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapRoll(bool value) {
    registerController.role.value = value ? "Cliend" : "Worker";
    registerController.isVisible.value = value;
  }

  void onTapController(String value) {
    print(value);
  }
}

class TypeJobItem{
  int id = 0;
  String? name;
  TypeJobItem({
    required this.id,
    this.name,
  });
}
