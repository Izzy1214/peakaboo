// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var credential = UserCredential;
// text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassController = TextEditingController();
  final _minValueController = TextEditingController();
  final _genderController = TextEditingController();
  final _phonenoController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _mednoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpassController.dispose();
    _genderController.dispose();
    _minValueController.dispose();
    _phonenoController.dispose();
    _emergencyController.dispose();
    _mednoController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //authentication
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      //add user details
      addUserDetails(
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

  Future addUserDetails(String fullname, int minValue, String gender,
      String email, int medical, int phoneno, int emergency) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).set({
      'Full Name': fullname,
      'minValue': minValue,
      'Gender': gender,
      'Email': email,
      'Medical Consultant Contact': medical,
      'Phone Number': phoneno,
      'Emergency Contact': emergency,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmpassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 15),
            Image(
              image: AssetImage("images/peak_monitor.png"),
            ),
            // Hello Again!
            Text(
              "Create Account!",
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
            // password textfield
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // confirm password textfield
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
                    controller: _confirmpassController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
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
                  onTap: () async {
                    signUp();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      'Register!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ),
                )),
            SizedBox(height: 25),
            // Already have an account? Sign in now
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(
                  '  Sign in Now!',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ]),
        ))));
  }

  // showAlertDialog(BuildContext context) {
  //   Navigator.pop(context);
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text(
  //       "OK",
  //       style: GoogleFonts.lato(fontWeight: FontWeight.bold),
  //     ),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(
  //       "Error!",
  //       style: GoogleFonts.lato(
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     content: Text(
  //       "Email already Exists",
  //       style: GoogleFonts.lato(),
  //     ),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  // bool emailValidate(String email) {
  //   if (RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // void _registerAccount() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var credential;

  //   try {
  //     credential = await _auth.createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //   } catch (error) {
  //     if (error.toString().compareTo(
  //             '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
  //         0) {
  //       showAlertDialog(context);
  //       print(
  //           "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  //       print(User);
  //     }
  //   }
  //   user = credential.user!;

  //   if (user != null) {
  //     if (!user.emailVerified) {
  //       await user.sendEmailVerification();
  //     }
  //     FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
  //       'Full Name': _nameController.text,
  //       'minValue': _minValueController.text,
  //       'Gender': _genderController.text,
  //       'Email': _emailController.text,
  //       'Medical Consultant Contact': _mednoController.text,
  //       'Phone Number': _phonenoController.text,
  //       'Emergency Contact': _emergencyController.text,
  //     }, SetOptions(merge: true));

  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  //   } else {}
  // }

  // void _pushPage(BuildContext context, Widget page) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(builder: (_) => page),
  //   );
  // }
}
