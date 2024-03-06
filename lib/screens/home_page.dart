import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/home_card.dart';
import 'doctors_list_page.dart';
import 'appointment_booking_page.dart';
import 'specialization_list_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              // Add your logic here to open the login page
              // For demonstration, let's navigate to a hypothetical LoginPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: HomeCard(
                  title: 'Doctor',
                  lottiePath: 'assets/lottie/doctor.json',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorsListPage()),
                    );
                  },
                ),
              ),
              Expanded(
                child: HomeCard(
                  title: 'Appointment',
                  lottiePath: 'assets/lottie/appointment.json',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpecializationListPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
