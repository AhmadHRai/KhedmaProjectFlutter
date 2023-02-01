import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import '../language/app_words.dart' as words;

BaseOptions options = BaseOptions(
  baseUrl: "http://p15khedma.looooon.com",
  connectTimeout: 10000,
  receiveTimeout: 10000,
);

Dio dio = Dio(options);

class MyApi{
  int progress = 0;
  int size = 0;
  var controller;
  Future? postRequest({
    String? apiName,
    Map<String, dynamic>? params,
    File? path,
    File? path_card,
    String conditionId = "",
    CancelToken? cancelToken,
  }) async {
    Response? response;

    try{
      if(path != null) {
        if(path.path.split("/").last == "tmp"){
          params!['path'] = null;
        }
        else{
          params!['path'] = MultipartFile.fromFileSync(
            path.path, filename: basename(path.path),
          );
        }
      }
      if(path_card != null) {
        if(path_card.path.split("/").last == "tmp"){
          params!['path_card'] = null;
        }
        else {
          params!['path_card'] = MultipartFile.fromFileSync(
            path_card.path, filename: basename(path_card.path),
          );
        }
      }

      if(conditionId != ""){
        conditionId = "/" + conditionId;
      }

      print("url: ${"http://p15khedma.looooon.com/api/${apiName}${conditionId}"}");
      print("params: ${params}");

      response = await dio.post(
        "http://p15khedma.looooon.com/api/${apiName}${conditionId}",
        data: FormData.fromMap(params!),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
          progress = sent;
          size = total;
          if(controller != null) {
            controller.progressRun(((sent / total) * 100).toInt());
          }
        },
        cancelToken: cancelToken
      );
      print("response data: ${response.data}");
      if(response.statusCode == 200 || response.statusCode == 201){
        Fluttertoast.showToast(
          msg: "Operation done successfully",
          backgroundColor: Colors.green,
        );
      }else{
        Fluttertoast.showToast(
          msg: "Failed to check internet connection",
          backgroundColor: Colors.red,
        );
      }
      return response.data;
    }catch(err){
      print("err postRequest: ${err}");
      if(err is DioError) {
        DioError dioError = err as DioError;
        print("err: ${dioError.message}");
        if (dioError.response == null) {
          print("خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر");
          Fluttertoast.showToast(
            msg: "خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر",
            backgroundColor: Colors.red,
            textColor: Colors.black,
          );
        }
        else {
          print("response status code: ${dioError.response!.statusCode}");
          if (dioError.response!.statusCode == 404) {
            print("خطا في السرفر قد يكون ملف php غير صحيح");
            Fluttertoast.showToast(
              msg: "خطا في السرفر قد يكون ملف php غير صحيح",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
          else if (dioError.response!.statusCode == 500) {
            print(
                "خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب");
            Fluttertoast.showToast(
              msg: "خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          } else {
            print("خطا لم يتم الرفع خطا غير متوقع");
            Fluttertoast.showToast(
              msg: "خطا لم يتم الرفع خطا غير متوقع",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
        }
      }
      else if(err is FileSystemException){
        FileSystemException fileSystemException = err as FileSystemException;
        print("err: ${fileSystemException.message}");
        Fluttertoast.showToast(
          msg: "خطا الملف الذي اخترته غير موجود او معطوب او تم الغاء الرفع او الرابط غير صحيح",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "خطا لم يتم الرفع خطا غير متوقع",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
    }
    return null;
  }

  Future getRequest({
    String? apiName,
    Map<String, dynamic>? params,
    String conditionId = "",
    CancelToken? cancelToken,
  }) async {
    Response? response;
    try{
      if(conditionId != ""){
        conditionId = "/" + conditionId;
      }

      response = await dio.get(
        "http://p15khedma.looooon.com/api/${apiName}${conditionId}",
        queryParameters: params,
        cancelToken: cancelToken
      );
      print("response data: ${response.data}");
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.data;
      }else{
        Fluttertoast.showToast(
          msg: "Failed to check internet connection",
          backgroundColor: Colors.red,
        );
      }
    }catch(err){
      print("err postRequest: ${err}");
      if(err is DioError) {
        DioError dioError = err as DioError;
        print("err: ${dioError.message}");
        if (dioError.response == null) {
          print("خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر");
          Fluttertoast.showToast(
            msg: "خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر",
            backgroundColor: Colors.red,
            textColor: Colors.black,
          );
        }
        else {
          print("response status code: ${dioError.response!.statusCode}");
          if (dioError.response!.statusCode == 404) {
            print("خطا في السرفر قد يكون ملف php غير صحيح");
            Fluttertoast.showToast(
              msg: "خطا في السرفر قد يكون ملف php غير صحيح",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
          else if (dioError.response!.statusCode == 500) {
            print(
                "خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب");
            Fluttertoast.showToast(
              msg: "خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          } else {
            print("خطا لم يتم الرفع خطا غير متوقع");
            Fluttertoast.showToast(
              msg: "خطا لم يتم الرفع خطا غير متوقع",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
        }
      }
      else if(err is FileSystemException){
        FileSystemException fileSystemException = err as FileSystemException;
        print("err: ${fileSystemException.message}");
        Fluttertoast.showToast(
          msg: "خطا الملف الذي اخترته غير موجود او معطوب او تم الغاء الرفع او الرابط غير صحيح",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "خطا لم يتم الرفع خطا غير متوقع",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
    }
  }
}
