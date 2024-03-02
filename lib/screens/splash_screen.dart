import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigitaToHome();
  }
  _navigitaToHome() async{
    await Future.delayed(Duration(seconds: 5),() {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>HomePage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Healthcare',style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w900),),
              SizedBox(height: 100),
              Image.asset('assets/images/healthcareLogo.png'),

            ],
          )
      ),
    );
  }
}
