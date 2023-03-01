
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_2/screen/add_employee_screen.dart';

import 'login_screen.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  var employeeID;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.popUntil(context, (route) => route.isFirst);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void deleteEmployee(String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              logout();
            },
            child: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.015,
                                horizontal: size.width * 0.02,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.012,
                                horizontal: size.width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      employeeID = documentSnapshot.id;
                                      Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              AddEmployeeScreen(
                                            isUpdate: true,
                                            myId: employeeID,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Text('  '),
                                        Text(
                                          documentSnapshot['surname'],
                                          style: TextStyle(
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteEmployee(documentSnapshot.id);
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AddEmployeeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.006,
                        horizontal: size.width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        const Text('Create New Employee '),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 10,
            ),
          ],
        ),
      ),
    );
  }
}
