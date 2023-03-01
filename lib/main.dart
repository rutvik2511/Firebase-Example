import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_2/screen/employee_list.dart';
import 'package:task_2/screen/login_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch data from firestore ( READ )
  // DocumentSnapshot snapshot = await firestore.collection("users").doc("kEe6lioO3tk5T5syJXcg").get();


  // Add data to firestore ( CREATE )
  // Map<String, dynamic> newUserData = {
  //   "name" : "Dipalee",
  //   "surname" : "Sojitra"
  // };
  // await firestore.collection("users").add(newUserData);


  // Add data to firestore with specific document id ( CREATE )
  // Map<String, dynamic> newUserData2 = {
  //   "name" : "Srushti",
  //   "surname" : "Gajera"
  // };
  // await firestore.collection("users").doc("Unique ID").set(newUserData2);

  // Update data to firestore ( UPDATE )
  // Map<String, dynamic> newUserData3 = {
  //   "name" : "Nisarg",
  //   "surname" : "Saple"
  // };
  // await firestore.collection("users").doc("Unique ID-2").update({"name" : "Mr. Nisarg"});


  // Delete data from firestore ( DELETE )
  // await firestore.collection("users").doc("Unique ID-2").delete();

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FireBase Example",
      home: (FirebaseAuth.instance.currentUser != null)
          ? const EmployeeList()
          : const LoginScreen(),
    );
  }
}
