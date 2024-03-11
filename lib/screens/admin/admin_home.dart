import 'package:flutter/material.dart';
import '../alluser/doctors_list_page.dart';
import 'Appointmentspage_admin.dart'; // Corrected: Added missing semicolon
import 'Patient_history_page.dart';
import 'book_appointment_page.dart';
import 'parients_list.dart'; // Updated filename to follow Dart's naming convention if necessary
import 'register_Doctor.dart';
// Import your other pages here

class AdminUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      home: AdminHomePage(),
      // Define routes for navigating to other screens
      routes: {
        '/doctors_list_page': (context) => DoctorsListPage(),
        '/register_Doctor': (context) => RegisterDoctorPage(),
        '/appointmentspage_admin': (context) => AppointmentPageAdmin(),
        '/patients_list': (context) => PatientsListPage(),
        '/patient_history_page': (context) => PatientHistoryPage(),
        '/book_appointment_page': (context) => BookAppointmentPage(),
      },
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    DoctorsListPage(),
    RegisterDoctorPage(),
    AppointmentPageAdmin(),
    PatientsListPage(),
    PatientHistoryPage(),
    BookAppointmentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Root User'),
              onTap: () {
                Navigator.of(context).pushNamed('/root_user_page');
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // Setting background color to white
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.deepPurple),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.deepPurple),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.deepPurple),
            label: 'Specializations',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // Color for selected item (icon and text)
        unselectedItemColor: Colors.grey, // Color for unselected items (icon and text)
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
