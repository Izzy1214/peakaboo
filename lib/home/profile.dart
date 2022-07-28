// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peak_app/breather/screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  // fetchUserData() {
  //   var firebaseUser = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc('tunQSi9kn4kVqanxWCPf')
  //       .get()
  //       .then((value) {
  //     print(value.data());
  //   });
  // }

  //final listProfile = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: usersCollection.doc(_auth!.uid).snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return Column(
              children: [
                SizedBox(height: 35),
                Container(
                  child: buildShowUserNameAndEmail(
                    text: streamSnapshot.data!['Full Name'],
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  child: buildShowUserNameAndEmail(
                    text: streamSnapshot.data!['Email'],
                    icon: Icons.email_outlined,
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  child: buildShowUserNameAndEmail(
                    text: streamSnapshot.data!['Gender'],
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}
