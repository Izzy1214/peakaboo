// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peak_app/breather/screen3.dart';
import 'package:peak_app/home/breathe.dart';
import 'package:peak_app/home/emergency.dart';
import 'package:peak_app/home/history.dart';
import 'package:peak_app/home/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

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
                        MaterialPageRoute(builder: (context) => HistoryPage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                    child: Text("History"),
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
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmergencyPage()),
                      )
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
}
