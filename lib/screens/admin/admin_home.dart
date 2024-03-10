import 'package:flutter/material.dart';
import '../alluser/doctors_list_page.dart';
import 'Appointmentspage_admin.dart'; // Corrected: Added missing semicolon
import 'Patient_history_page.dart';
import 'book_appointment_page.dart';
import 'parients_list.dart'; // Updated filename to follow Dart's naming convention if necessary
import 'register_Doctor.dart';
// Import your other pages here

class AdminUser extends StatelessWidget { // Corrected: Added 'class' keyword
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      home: AdminHomePage(),
      // Define routes for navigating to other screens
      routes: {
        '/doctors_list_page': (context) => DoctorsListPage(), // Corrected route name
        '/register_Doctor': (context) => RegisterDoctorPage(),
        '/appointmentspage_admin': (context) => AppointmentPageAdmin(), // Corrected route name
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
  void navigateToSection(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // Drawer items...
          ],
        ),
      ),
      body: _buildDashboardContent(),
    );
  }

// Drawer items and dashboard content methods remain the same
}


  Widget _buildDashboardContent() {
    // Implement your dashboard content here
    return Container(); // Placeholder container for now
  }



