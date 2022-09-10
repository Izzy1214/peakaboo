// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors, avoid_print, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:peak_app/breather/screen2.dart';
import 'package:flutter_sms/flutter_sms.dart';

class BreathePage extends StatefulWidget {
  const BreathePage({Key? key}) : super(key: key);
  @override
  _BreathePageState createState() => _BreathePageState();
}

class _BreathePageState extends State<BreathePage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  late String peakText;
  final DatabaseReference _pevRef = FirebaseDatabase.instance
      .refFromURL('https://peak-app-project-default-rtdb.firebaseio.com/');
  late AnimationController progressController;
  late Animation<double> pevAnimation;

  @override
  void initState() {
    super.initState();
    peakText = "Showing result Here Soon ...";
    _pevRef.child('Peak Expiratory Value').onValue.listen((event) async {
      var snapshot = event.snapshot;
      var pevv = snapshot.value;
      print('Value is $pevv');
      var p = int.parse(pevv.toString());
      double peak = p / 1;
      var collection = FirebaseFirestore.instance.collection('Users');
      var docSnapshot = await collection.doc(user!.uid).get();
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['minValue'];
      var num1 = data?['Emergency Contact'];
      var num2 = data?['Medical Consultant Contact'];
      String messages =
          "This is an Emergency, Patient with Id No. 001 is in dire need of medical attention";
      List<String> recipient = ["+234$num1", "+234$num2"];
      if (peak < value) {
        _sendSMS(messages, recipient);
        _setMarqueeText(peak, value);
      } else {
        savePeak(peak);
        _setMarqueeText(peak, value);
      }
      isLoading = true;
      _DashboardInit(peak);
    });
  }

  @override
  _DashboardInit(pevv) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    pevAnimation =
        Tween<double>(begin: 0, end: pevv).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Check your Peak Value"),
        ),
        body: Column(children: [
          Container(
            height: 30,
            child: _buildMarquee(),
          ),
          Expanded(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomPaint(
                          foregroundPainter: CircleProgress(pevAnimation.value),
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Peak Value'),
                                  Text(
                                    '${pevAnimation.value.toInt()}',
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'L/MIN',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Loading...',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
        ]));
  }

  Future savePeak(double peak) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('PeakValues')
        .doc(user!.uid)
        .set({
      'minValue': peak,
    });
  }

  _setMarqueeText(peak, value) {
    peakText = "PEV: ${peak.toStringAsFixed(1)} L/MIN, ";
    if (peak > 0 && peak < value) {
      peakText += "Emergency Message Sent  ";
    } else if (peak > 400 && peak <= 1000) {
      peakText += "Peak Expiratory Value is in safe Zone  ";
    }
  }

  Widget _buildMarquee() {
    return Marquee(
        child: Text(peakText,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)));
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
