import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import 'appointment_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DoctorHomePage> {
  int _selectedIndex = 0;
  late Future<List<Appointment>> todaysAppointments;

  @override
  void initState() {
    super.initState();
    todaysAppointments = loadTodaysAppointments();
  }

  Future<List<Appointment>> loadTodaysAppointments() async {
    final String response = await rootBundle.loadString('assets/data/appointments.json');
    final List<dynamic> data = json.decode(response);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String today = formatter.format(DateTime.now());

    List<Appointment> todaysAppointments = data.map((json) => Appointment.fromJson(json)).where((appointment) {
      return appointment.date == today && appointment.status == 'active';
    }).toList();

    return todaysAppointments;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the AppointmentPage if needed, etc.
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      WelcomePage(todaysAppointments: todaysAppointments), // Pass Future as a parameter
      AppointmentPage(),
      // Other pages as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Doctor"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.deepPurple),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.deepPurple),
            label: 'Appointments',
          ),
          // Additional tabs as needed
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
class WelcomePage extends StatelessWidget {
  final Future<List<Appointment>> todaysAppointments;

  const WelcomePage({Key? key, required this.todaysAppointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: todaysAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text("Error loading appointments."));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No appointments for today."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Appointment appointment = snapshot.data![index];
              return ListTile(
                title: Text('Appointment with ${appointment.patientName}'),
                subtitle: Text('Date: ${appointment.date}, Time: ${appointment.timeSlot}'),
                // You can add more details or an onTap function here
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

