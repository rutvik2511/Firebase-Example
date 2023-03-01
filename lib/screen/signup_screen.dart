import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2/screen/employee_list.dart';

import '../controller/signup_controller.dart';
import '../custom_widget/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController controller = Get.put(
    SignupController(),
  );

  void createAccount() async {
    // String fistName = controller.firstName.value.text.trim();
    // String lastName = controller.lastName.value.text.trim();
    String email = controller.email.value.text.trim();
    String password = controller.password.value.text.trim();
    String confirmPassword = controller.confirmPassword.value.text.trim();

    if (email == "" || password == "" || confirmPassword == "") {
      log("Please fill all details...");
    } else if (password != confirmPassword) {
      log("Both password should be same");
    } else {

      try{
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if(userCredential.user != null) {
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
        log('User created successfully...');
      } on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
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
                hint: "First Name",
                controller: controller.firstName.value,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hint: "Last Name",
                controller: controller.lastName.value,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hint: "Email",
                controller: controller.email.value,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hint: "Password",
                controller: controller.password.value,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                hint: "Confirm Password",
                controller: controller.confirmPassword.value,
              ),

              SizedBox(
                height: size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  createAccount();
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
