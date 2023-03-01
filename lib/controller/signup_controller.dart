import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
}