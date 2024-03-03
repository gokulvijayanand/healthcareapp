import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart';
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
              image: DecorationImage(
                image: AssetImage("assets/images/doctor_sp.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [LightColor.purpleExtraLight, LightColor.purple],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              SizedBox(height: 275),
              //Image.asset("assets/images/heartbeat.png", color: Colors.white,height: 100,),
              Card(
                shape: RoundedRectangleBorder( // This rounds the corners of the Card
                borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.deepPurple,

                child: Text(
                  "Health Care",
                  style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700 )
                ),
              ),
              Text(
                "By Gokul HealthCare Team",
                style: TextStyle(color: Colors.deepPurple,fontSize: 30,fontWeight: FontWeight.normal ),
              ),
              Lottie.asset(
                'assets/lottie/heart_beat.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              Expanded(
                flex: 7,
                child: SizedBox(),
              ),
            ],
          ).alignTopCenter,
        ],
      ),
    );
  }
}
