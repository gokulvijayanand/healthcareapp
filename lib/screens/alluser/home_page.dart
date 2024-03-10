import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/home_card.dart';
import 'doctors_list_page.dart';
import 'appointment_booking_page.dart';
import 'specialization_list_page.dart';
import 'login_page.dart';
import '../../models/doctor.dart';
import 'doctor_detail_page.dart';
import '../doctor/doctor_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    WelcomePage(), // Welcome page added
    DoctorsListPage(),
    AppointmentBookingPage(),
    SpecializationListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              // Navigating to the login page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        // Setting background color to purple
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people,color: Colors.deepPurple),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month,color: Colors.deepPurple),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list,color: Colors.deepPurple),
            label: 'Specializations',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // Color for selected item (icon and text)
        unselectedItemColor: Colors.white, // Color for unselected items (icon and text)
        onTap: _onItemTapped,

      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Page',
              style: TextStyle(fontSize: 20.0, color: Colors.purple),
            ),
            SizedBox(height: 20),
            Text(
              'Tap on the bottom navigation icons to navigate.',
              style: TextStyle(fontSize: 16.0, color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}

