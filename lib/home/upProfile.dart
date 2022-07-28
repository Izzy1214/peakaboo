// ignore_for_file: prefer_const_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _minValueController = TextEditingController();
  final _genderController = TextEditingController();
  final _phonenoController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _mednoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _minValueController.dispose();
    _phonenoController.dispose();
    _emergencyController.dispose();
    _mednoController.dispose();
    super.dispose();
  }

  Future saveDetails() async {
    //authentication
    if (_nameController.text.trim() == _nameController.text.trim()) {
      updateDetails(
        _nameController.text.trim(),
        int.parse(_minValueController.text.trim()),
        _genderController.text.trim(),
        _emailController.text.trim(),
        int.parse(_mednoController.text.trim()),
        int.parse(_phonenoController.text.trim()),
        int.parse(_emergencyController.text.trim()),
      );
    }
  }

  Future updateDetails(String fullname, int minValue, String gender,
      String email, int medical, int phoneno, int emergency) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).update({
      'Full Name': fullname,
      'minValue': minValue,
      'Gender': gender,
      'Email': email,
      'Medical Consultant Contact': medical,
      'Phone Number': phoneno,
      'Emergency Contact': emergency,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Page"),
        ),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 15),
            Image(
              image: AssetImage("images/user-286.png"),
            ),
            // Hello Again!
            Text(
              "Update User Details",
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            SizedBox(height: 35),
            // name textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // maxValue textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _minValueController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Minimum Peak Value',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // gender textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Gender',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // phone no textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _phonenoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
//Emergency Contact textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _emergencyController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Emergency Contact Number',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Medical Email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _mednoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Medical Consultant Number',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Register button
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: saveDetails,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ),
                )),
          ]),
        ))));
  }
}
