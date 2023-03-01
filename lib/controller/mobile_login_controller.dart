import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileLoginController extends GetxController{
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;
}