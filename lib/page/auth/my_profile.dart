import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khdma/api/myapi.dart';
import 'package:khdma/page/splash/splash_page.dart';
import '../../vars.dart' as v;
import '../../funs.dart' as f;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  static const id = "/MyProfile";

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _txtname =
      TextEditingController(text: "${v.userData['name']}");
  TextEditingController _txtemail =
      TextEditingController(text: "${v.userData['email']}");
  TextEditingController _txtphone =
      TextEditingController(text: "${v.userData['phone']}");
  TextEditingController _txtpassword = TextEditingController();
  TextEditingController _txtaddress =
      TextEditingController(text: "${v.userData['address']}");

  String? path_name;
  File? path;
  String? path_card_name;
  File? path_card;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String booking = "${v.userData['booking'] ?? 0}";

  @override
  void initState() {
    super.initState();
    if (v.userData['path'] != null) {
      path_name = v.userData['path'];
    }
    if (v.userData['path_card'] != null) {
      path_card_name = v.userData['path_card'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  // upload path card ________________________________________________
                  Container(
                    height: 350,
                    width: Get.width,
                    child: Builder(builder: (context) {
                      bool ischoosing = false;
                      bool delete_file = false;
                      return StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: [
                            Container(
                              height: 300,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            height: 300,
                                            width: Get.width,
                                            "${v.storageLink}${v.userData['path_card']}",
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, obj, st) {
                                              return Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              );
                                            },
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                padding: EdgeInsets.all(4),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: (ischoosing == false)
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                elevation: 5,
                                                primary: Colors.white
                                                    .withOpacity((delete_file ==
                                                                false &&
                                                            path_card_name !=
                                                                null)
                                                        ? 0.1
                                                        : 1),
                                                onPrimary: Colors.black),
                                            child: (path_card == null ||
                                                    path_card!.path
                                                        .toString()
                                                        .contains("tmp"))
                                                ? Icon(
                                                    (delete_file == false &&
                                                            path_card_name !=
                                                                null)
                                                        ? Icons.edit
                                                        : Icons.camera_alt,
                                                    size: 40,
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0,
                                                            child: Image.file(
                                                              path_card!,
                                                              fit: BoxFit.cover,
                                                            )),
                                                        Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          top: 0,
                                                          bottom: 0,
                                                          child: TextButton(
                                                            style: ElevatedButton.styleFrom(
                                                                primary: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                onPrimary:
                                                                    Colors
                                                                        .white),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 30,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              ischoosing = true;
                                                              setState(() {});
                                                              if (path_card !=
                                                                  null) {
                                                                if (path_card!
                                                                    .existsSync()) {
                                                                  path_card!
                                                                      .deleteSync();
                                                                  path_card =
                                                                      null;
                                                                }
                                                              }
                                                              ischoosing =
                                                                  false;
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            onPressed: () async {
                                              ischoosing = true;
                                              setState(() {});
                                              path_card =
                                                  await Get.defaultDialog(
                                                title: "التقاط صورة",
                                                content: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                            iconSize: 42,
                                                            icon: Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(await f.picturePicker(
                                                                      fromCamera:
                                                                          true));
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
                                                              Icons.image,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(await f.picturePicker(
                                                                      fromCamera:
                                                                          false));
                                                            },
                                                          ),
                                                          Text("المعرض"),
                                                        ],
                                                      ),
                                                      if (path_card_name !=
                                                          null)
                                                        Column(
                                                          children: [
                                                            IconButton(
                                                              iconSize: 42,
                                                              icon: Icon(
                                                                (delete_file ==
                                                                        false)
                                                                    ? Icons
                                                                        .delete
                                                                    : Icons
                                                                        .refresh,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if ((delete_file ==
                                                                    false)) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(File(
                                                                          await f
                                                                              .tmpFilePath()));
                                                                  // Navigator.of(context).pop(null);
                                                                  delete_file =
                                                                      true;
                                                                  setState(
                                                                      () {});
                                                                } else {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          null);
                                                                  delete_file =
                                                                      false;
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                            ),
                                                            Text((delete_file ==
                                                                    false)
                                                                ? "حذف"
                                                                : "تراجع"),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ).then((value) async {
                                                print(
                                                    "path_card: " + value.path);
                                                return value;
                                              }).catchError((err) {
                                                return null;
                                              });
                                              if (path_card != null) {
                                                print(
                                                    "name file: ${path_card!.path.split("/").last}, size file: ${path_card!.lengthSync() / (1024 * 1024)}");
                                              }
                                              ischoosing = false;
                                              setState(() {});
                                            },
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                elevation: 5,
                                                primary: Colors.white
                                                    .withOpacity((delete_file ==
                                                                false &&
                                                            path_card_name !=
                                                                null)
                                                        ? 0.2
                                                        : 1),
                                                onPrimary: Colors.black),
                                            onPressed: () {},
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.black))),
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                    }),
                  ),
                  // end upload path card ________________________________________________

                  // image upload _____________________________________________________
                  ClipOval(
                    child: Container(
                      height: 120,
                      width: 120,
                      child: Builder(builder: (context) {
                        bool ischoosing = false;
                        bool delete_file = false;
                        return StatefulBuilder(builder: (context, setState) {
                          return Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        height: 120,
                                        width: 120,
                                        "${v.storageLink}${v.userData['path']}",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, obj, st) {
                                          return Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                            padding: EdgeInsets.all(4),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: (ischoosing == false)
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0),
                                            elevation: 5,
                                            primary: Colors.white.withOpacity(
                                                (delete_file == false &&
                                                        path_name != null)
                                                    ? 0.2
                                                    : 1),
                                            onPrimary: Colors.black),
                                        child: (path == null ||
                                                path!.path
                                                    .toString()
                                                    .contains("tmp"))
                                            ? Icon(
                                                (delete_file == false &&
                                                        path_name != null)
                                                    ? Icons.edit
                                                    : Icons.camera_alt,
                                                size: 40,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        top: 0,
                                                        bottom: 0,
                                                        child: Image.file(
                                                          path!,
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: TextButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                onPrimary:
                                                                    Colors
                                                                        .white),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                        onPressed: () async {
                                                          ischoosing = true;
                                                          setState(() {});
                                                          if (path != null) {
                                                            if (path!
                                                                .existsSync()) {
                                                              path!
                                                                  .deleteSync();
                                                              path = null;
                                                            }
                                                          }
                                                          ischoosing = false;
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        onPressed: () async {
                                          ischoosing = true;
                                          setState(() {});
                                          path = await Get.defaultDialog(
                                            title: "التقاط صورة",
                                            content: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        iconSize: 42,
                                                        icon: Icon(
                                                          Icons.camera_alt,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop(await f
                                                                  .picturePicker(
                                                                      fromCamera:
                                                                          true));
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
                                                          Icons.image,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop(await f
                                                                  .picturePicker(
                                                                      fromCamera:
                                                                          false));
                                                        },
                                                      ),
                                                      Text("المعرض"),
                                                    ],
                                                  ),
                                                  if (path_name != null)
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                          iconSize: 42,
                                                          icon: Icon(
                                                            (delete_file ==
                                                                    false)
                                                                ? Icons.delete
                                                                : Icons.refresh,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () async {
                                                            if ((delete_file ==
                                                                false)) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(File(await f
                                                                      .tmpFilePath()));
                                                              // Navigator.of(context).pop(null);
                                                              delete_file =
                                                                  true;
                                                              setState(() {});
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(null);
                                                              delete_file =
                                                                  false;
                                                              setState(() {});
                                                            }
                                                          },
                                                        ),
                                                        Text((delete_file ==
                                                                false)
                                                            ? "حذف"
                                                            : "تراجع"),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ).then((value) async {
                                            print("path: " + value.path);
                                            return value;
                                          }).catchError((err) {
                                            return null;
                                          });
                                          if (path != null) {
                                            print(
                                                "name file: ${path!.path.split("/").last}, size file: ${path!.lengthSync() / (1024 * 1024)}");
                                          }
                                          ischoosing = false;
                                          setState(() {});
                                        },
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0),
                                            elevation: 5,
                                            primary: Colors.white.withOpacity(
                                                (delete_file == false &&
                                                        path_name != null)
                                                    ? 0.2
                                                    : 1),
                                            onPrimary: Colors.black),
                                        onPressed: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 50,
                                                width: 50,
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.black))),
                                          ],
                                        ),
                                      ),
                              ),
                            ],
                          );
                        });
                      }),
                    ),
                  ),
                  // end image upload _____________________________________________________
                ],
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: _txtname,
                        validator: (String? val) {
                          if (val == null || val == "") {
                            return "لا يمكن ترك هذا الحقل فارغ";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.blue,
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: _txtemail,
                        validator: (String? val) {
                          if (val == null || val == "") {
                            return "لا يمكن ترك هذا الحقل فارغ";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone_outlined,
                          color: Colors.blue,
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: _txtphone,
                        keyboardType: TextInputType.phone,
                        validator: (String? val) {
                          if (val == null || val == "") {
                            return "لا يمكن ترك هذا الحقل فارغ";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.password_outlined,
                          color: Colors.blue,
                        )),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        controller: _txtpassword,
                        validator: (String? val) {
                          if (val == null || val == "") {
                            return "لا يمكن ترك هذا الحقل فارغ";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Password ..."),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_history,
                          color: Colors.blue,
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: _txtaddress,
                        validator: (String? val) {
                          if (val == null || val == "") {
                            return "لا يمكن ترك هذا الحقل فارغ";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                child: StatefulBuilder(builder: (context, setStateInternal) {
                  return CheckboxListTile(
                    value: (booking == "1") ? true : false,
                    title: Text(" Is Booking? "),
                    onChanged: (bool? value) {
                      if (value == true) {
                        booking = "1";
                      } else {
                        booking = "0";
                      }
                      setStateInternal(() {});
                    },
                  );
                }),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                child: Builder(builder: (context) {
                  bool isUploading = false;
                  return StatefulBuilder(builder: (context, setStateInternal) {
                    return Visibility(
                      visible: !isUploading,
                      replacement: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          MyApi myApi = MyApi();
                          if (_formkey.currentState!.validate() == true) {
                            isUploading = true;
                            setStateInternal(() {});

                            await myApi.postRequest(
                              apiName: "userupdate",
                              conditionId: "${v.userData['id']}",
                              path: path,
                              path_card: path_card,
                              params: {
                                'name': "${_txtname.text}",
                                'email': "${_txtemail.text}",
                                'phone': "${_txtphone.text}",
                                'password': "${_txtpassword.text}",
                                'address': "${_txtaddress.text}",
                                'booking': booking
                              },
                            );
                            await Future.delayed(Duration(milliseconds: 250));
                            // login ______________________________
                            Map? response = await myApi.postRequest(
                              apiName: "userlogin",
                              params: {
                                'email': "${_txtemail.text}",
                                'password': "${_txtpassword.text}",
                              },
                            );
                            if (response != null) {
                              String user = jsonEncode(response);
                              print("user: ${user}");
                              await GetStorage().write("user", "${user}");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Failed in login",
                                  backgroundColor: Colors.red);
                            }
                            isUploading = false;
                            setStateInternal(() {});
                            await Future.delayed(Duration(milliseconds: 250));
                            Get.offAll(() => SplashPage());
                          }
                        },
                        child: Text("Profile Edit"),
                      ),
                    );
                  });
                }),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width * 0.9,
                height: 50,
                child: Builder(builder: (context) {
                  bool isUploading = false;
                  return StatefulBuilder(builder: (context, setStateInternal) {
                    return Visibility(
                      visible: !isUploading,
                      replacement: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () async {
                          GetStorage().write("user", null);
                          Get.offAll(() => SplashPage());
                          Fluttertoast.showToast(msg: "Log out successfully");
                        },
                        child: Text("Log out"),
                      ),
                    );
                  });
                }),
              ),

              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
