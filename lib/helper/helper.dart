import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as d;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  static String convertToKhmerPhoneNumber({required String number}) {
    return number;
  }

  static List<String> convertStringtoListString({required String data}) {
    return json.decode(data);
  }

  static String convertListStringtoString({required List<String> data}) {
    String result = '"["';
    result += data.join('","');
    result += '"]"';
    return result;
  }

  static String manipulatePhoneNumber(
      {required String code, required String phoneNumber}) {
    String finalPhoneNumber = phoneNumber;
    if (phoneNumber[0] == "0") {
      finalPhoneNumber = phoneNumber.substring(1);
    }
    d.log("PhoneNumber: $phoneNumber");
    d.log("code: $code");
    d.log("finalPhoneNumber: $finalPhoneNumber");
    finalPhoneNumber = (code + finalPhoneNumber).replaceAll("+", "");
    d.log(finalPhoneNumber);
    return finalPhoneNumber;
  }

 

  static void imgFromGallery(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile imageP =
        (await picker.getImage(source: ImageSource.gallery, imageQuality: 50))!;
    final File image = File(imageP.path);
    onPicked(image);
  }

  static void imgFromCamera(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile imageP =
        (await picker.getImage(source: ImageSource.camera, imageQuality: 50))!;
    final File image = File(imageP.path);
    onPicked(image);
  }

  

 
}
