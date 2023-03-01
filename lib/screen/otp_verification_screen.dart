import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2/screen/employee_list.dart';

import '../controller/mobile_login_controller.dart';
import '../custom_widget/custom_text_field.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;

  const OTPVerificationScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final MobileLoginController controller = Get.put(
    MobileLoginController(),
  );

  void verifyOTP() async {
    String otp = controller.otp.value.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.popUntil(context, (route) => route.isFirst);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const EmployeeList(),
          ),
        );
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
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
                hint: "ENTER OTP  ",
                controller: controller.otp.value,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  verifyOTP();
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
