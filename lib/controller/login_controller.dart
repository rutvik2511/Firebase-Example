import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
}