import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2/controller/mobile_login_controller.dart';
import 'package:task_2/screen/otp_verification_screen.dart';
import '../custom_widget/custom_text_field.dart';

class LoginWithMobileNumber extends StatefulWidget {
  const LoginWithMobileNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithMobileNumber> createState() => _LoginWithMobileNumberState();
}

class _LoginWithMobileNumberState extends State<LoginWithMobileNumber> {
  final MobileLoginController controller = Get.put(
    MobileLoginController(),
  );

  void sendOTP() async {
    String mobileNumber = "+91${controller.mobileNumber.value.text.trim()}";
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: mobileNumber,
          codeSent: (verificationId, resendToken) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>  OTPVerificationScreen(verificationId: verificationId,),
              ),
            );
          },
          verificationCompleted: (credential) {},
          verificationFailed: (ex) {
            log(ex.code.toString());
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 50,
              ),
              CustomTextField(
                hint: "Mobile Number",
                controller: controller.mobileNumber.value,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  sendOTP();
                },
                child: const Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
