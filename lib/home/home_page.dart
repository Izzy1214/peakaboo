// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:peak_app/home/breathe.dart';
import 'package:peak_app/home/upProfile.dart';
import 'package:peak_app/home/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user = FirebaseAuth.instance.currentUser;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("DashBoard"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MaterialButton(
                    height: 250.0,
                    minWidth: 150.0,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BreathePage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                    child: Text("Breathe"),
                  )),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MaterialButton(
                    height: 250.0,
                    minWidth: 150.0,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdatePage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                    child: Text("Update Profile"),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MaterialButton(
                    height: 250.0,
                    minWidth: 150.0,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () async {
                      var collection =
                          FirebaseFirestore.instance.collection('Users');
                      var docSnapshot = await collection.doc(user!.uid).get();
                      Map<String, dynamic>? data = docSnapshot.data();
                      var num1 = data?['Emergency Contact'];
                      var num2 = data?['Medical Consultant Contact'];
                      String messages =
                          "This is an Emergency, Patient with Id No. 001 is in dire need of medical attention";
                      List<String> recipient = ["+234$num1", "+234$num2"];
                      _sendSMS(messages, recipient);
                    },
                    splashColor: Colors.redAccent,
                    child: Text("Emergency"),
                  )),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MaterialButton(
                    height: 250.0,
                    minWidth: 150.0,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                    child: Text("Profile"),
                  )),
            ],
          ),

          SizedBox(height: 50),
          //menu bar
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.deepPurpleAccent,
            child: Text('Sign Out'),
          )
        ])));
  }

  void _sendSMS(String message, List<String> recipients) async {
    String result = await sendSMS(
            message: message, recipients: recipients, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }
}
