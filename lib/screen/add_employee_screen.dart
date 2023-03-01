import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_2/custom_widget/custom_text_field.dart';
import 'package:task_2/screen/employee_list.dart';

class AddEmployeeScreen extends StatefulWidget {
  final bool isUpdate;
  final String? myId;

  const AddEmployeeScreen({
    Key? key,
    this.isUpdate = false,
    this.myId,
  }) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreen();
}

class _AddEmployeeScreen extends State<AddEmployeeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  late String name;
  late String surname;

  @override
  void initState() {
    updateEmployee();
    super.initState();
  }

  void createEmployee() async {
    final String name = nameController.text;
    final String surname = surnameController.text;

    if (name.isNotEmpty == true && surname.isNotEmpty == true) {
      await FirebaseFirestore.instance.collection('users').add({
        "name": name,
        "surname": surname,
      });
    }
    nameController.text = '';
    surnameController.text = '';
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const EmployeeList(),
      ),
    );
  }

  void updateEmployee() async {
    if (widget.isUpdate == true) {
      setState(() {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.myId.toString())
            .get()
            .then((DocumentSnapshot) {
          name = DocumentSnapshot['name'].toString();
          surname = DocumentSnapshot['surname'].toString();
          nameController.text = name;
          surnameController.text = surname;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.02),
        child: Column(
          children: [
            CustomTextField(controller: nameController, hint: "Name"),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextField(controller: surnameController, hint: "Surname"),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                 widget.isUpdate
                    ? GestureDetector(
                  onTap: () {
                    var param = {
                      'name': nameController.text,
                      'surname': surnameController.text,
                    };
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.myId.toString())
                        .update(param);


                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const EmployeeList(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.009,
                      horizontal: size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                    ),
                    child: const Text('Update Employee'),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    createEmployee();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.009,
                      horizontal: size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue,
                    ),
                    child: const Text('Add Employee'),
                  ),
                ),


                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
