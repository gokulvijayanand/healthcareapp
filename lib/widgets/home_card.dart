import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String lottiePath;

  const HomeCard({
    Key? key,
    required this.title,
    required this.lottiePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder( // This rounds the corners of the Card
        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        child: Container(
          color: Colors.purple,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2, // 10% of the body height
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(lottiePath,
                width: 50,
                height: 70,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 10),
              Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
