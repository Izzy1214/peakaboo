// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:peak_app/breather/screen2.dart';

class BreathePage extends StatefulWidget {
  const BreathePage({Key? key}) : super(key: key);
  @override
  _BreathePageState createState() => _BreathePageState();
}

class _BreathePageState extends State<BreathePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  final DatabaseReference _pevRef = FirebaseDatabase.instance
      .refFromURL('https://peak-app-project-default-rtdb.firebaseio.com/');
  late AnimationController progressController;
  late Animation<double> pevAnimation;

  @override
  void initState() {
    super.initState();

    _pevRef.child('Peak Expiratory Value').onValue.listen((event) {
      var snapshot = event.snapshot;
      var pevv = snapshot.value;
      print('Value is $pevv');
      var p = int.parse(pevv.toString());
      double peak = p / 1;
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
      body: Center(
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
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'L/MIN',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
    );
  }
}
