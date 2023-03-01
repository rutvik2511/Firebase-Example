import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:task_2/controller/login_controller.dart';
import 'package:task_2/custom_widget/custom_text_field.dart';
import 'package:task_2/screen/employee_list.dart';
import 'package:task_2/screen/login_with_number_screen.dart';
import 'package:task_2/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(
    LoginController(),
  );

  @override
  void dispose() {
    // controller.email.value.dispose();
    // controller.password.value.dispose();
    super.dispose();
  }

  void login() async {
    String email = controller.email.value.text.trim();
    String password = controller.password.value.text.trim();

    if (email == "" || password == "") {
      log("Please fill all details...");
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        log('User logged in successfully...');
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
  }

  void loginWithGoogle() async {
    log("googleLogin method Called");
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
      if (result == null) {
        return;
      } else {
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

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
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
                height: size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text('Log In'),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Text(
                'Login With',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.05),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginWithMobileNumber(),
                    ),
                  );
                },
                child: Text(
                  'Mobile Number',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.04,
                      color: Colors.blue.withOpacity(0.8)),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                ' OR ',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: size.width * 0.04),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      loginWithGoogle();
                    },
                    child: Image.asset(
                      "assets/images/google.png",
                      scale: size.width * 0.030,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Image.asset(
                    "assets/images/apple.png",
                    scale: size.width * 0.030,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have account ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}