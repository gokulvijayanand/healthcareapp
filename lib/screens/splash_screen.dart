import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myflutterproject/screens/alluser//loginpage.dart';
import 'alluser/home_page.dart';
import 'package:myflutterproject/theams/light_color.dart';
import 'package:myflutterproject/theams/text_styles.dart';
import 'package:myflutterproject/theams/extention.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  LightColor.purpleLight,
                  LightColor.purple,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  "Health Care",
                  style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "By Gokul HealthCare Team",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 20),
                Lottie.asset(
                  'assets/lottie/heart_beat.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
