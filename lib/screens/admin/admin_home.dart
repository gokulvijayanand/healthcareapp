import 'package:flutter/material.dart';
import '../alluser/doctors_list_page.dart';
import 'Appointmentspage_admin.dart';
import 'Patient_history_page.dart';
import 'book_appointment_page.dart';
import 'parients_list.dart';
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
        '../alluser/doctors_list_page': (context) => DoctorsListPage(),
        '/register_Doctor': (context) => RegisterDoctorPage(),
        '/appointmentspage_adimin': (context) => AppointmentPageAdmin(),
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
            DrawerHeader(
              child: Text('Admin Panel', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            _buildDrawerItem(
                icon: Icons.medical_services,
                text: 'Doctors List',
                onTap: () => navigateToSection('/doctorsList')),
            _buildDrawerItem(
                icon: Icons.person_add,
                text: 'Register Doctor',
                onTap: () => navigateToSection('/registerDoctor')),
            _buildDrawerItem(
                icon: Icons.view_agenda,
                text: 'Appointments',
                onTap: () => navigateToSection('/appointments')),
            _buildDrawerItem(
                icon: Icons.people,
                text: 'Patients List',
                onTap: () => navigateToSection('/patientsList')),
            _buildDrawerItem(
                icon: Icons.history,
                text: 'Patient History',
                onTap: () => navigateToSection('/patientHistory')),
            _buildDrawerItem(
                icon: Icons.book_online,
                text: 'Book Appointment',
                onTap: () => navigateToSection('/bookAppointment')),
          ],
        ),
      ),
      body: _buildDashboardContent(),
    );
  }

  Widget _buildDrawerItem({IconData? icon, String? text, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text!),
      onTap: onTap,
    );
  }

  Widget _buildDashboardContent() {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: <Widget>[
        _buildDashboardCard('Doctors List', Icons.medical_services, () => navigateToSection('/doctorsList')),
        _buildDashboardCard('Register Doctor', Icons.person_add, () => navigateToSection('/registerDoctor')),
        _buildDashboardCard('View Appointments', Icons.view_agenda, () => navigateToSection('/appointments')),
        _buildDashboardCard('Patients List', Icons.people, () => navigateToSection('/patientsList')),
        _buildDashboardCard('Patient History', Icons.history, () => navigateToSection('/patientHistory')),
        _buildDashboardCard('Book Appointment', Icons.book_online, () => navigateToSection('/bookAppointment')),
      ],
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
