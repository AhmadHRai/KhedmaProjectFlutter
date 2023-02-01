import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File?> picturePicker({required bool fromCamera}) async {
  XFile? xFile;
  try {
    if (fromCamera) {
      xFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50
      );
    }
    else {
      xFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 50
      );
    }
    if (xFile != null) {
      File file = File(xFile.path);
      double size = file.lengthSync() / (1024 * 1024);
      print("size file: ${size}");
      if (size > 3) {
        Fluttertoast.showToast(
          msg: "فشل حجم الملف كبير تعدى 3mb",
          backgroundColor: Colors.amber,
          textColor: Colors.black,
        );
        return null;
      }
      return file;
    } else {
      Fluttertoast.showToast(
        msg: "لم تختار ملف",
        backgroundColor: Colors.amber,
        textColor: Colors.black,
      );
      return null;
    }
  }catch(err){
    print("err: ${err}");
    Fluttertoast.showToast(
      msg: "فشل غير متوقع",
      backgroundColor: Colors.amber,
      textColor: Colors.black,
    );
    return null;
  }

}

Future<String> tmpFilePath() async {
  try {
    var external_path = (await getExternalStorageDirectory())?.path;
    if(File(join(external_path!, "tmp")).existsSync()) {
      return join(external_path, "tmp");
    }else{
      ByteData assetfile = await rootBundle.load("assets/images/tmp");
      List<int> bytes = assetfile.buffer.asUint8List(
          assetfile.offsetInBytes, assetfile.lengthInBytes);
      return (await File(join(external_path, "tmp")).writeAsBytes(bytes)).path;
    }
  }catch(err){
    print("err: ${err}");
  }
  return "";
}
