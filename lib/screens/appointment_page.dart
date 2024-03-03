import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctor.dart'; // Import your Doctor model
import 'dart:convert';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({Key? key, required this.doctor}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late List<dynamic> appointments = [];
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDoctorAppointments();
  }

  Future<void> loadDoctorAppointments() async {
    // Load the appointment data from the JSON file
    final String response = await rootBundle.loadString('assets/data/appointments.json');
    final data = json.decode(response);
    // Assuming your JSON structure has an array of appointments for each doctor ID
    final doctorAppointments = data.firstWhere(
          (item) => item['doctorId'].toString() == widget.doctor.id,
      orElse: () => {'appointments': []},
    )['appointments'];
    setState(() {
      appointments = doctorAppointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment with ${widget.doctor.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display free slots, assuming you filter out the booked slots
            ...appointments.map((appointment) => ListTile(
              title: Text("${appointment['date']} - ${appointment['timeSlot']}"),
              onTap: () {
                // Handle slot selection
              },
            )).toList(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason for Appointment',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement booking logic
                print('Reason: ${_reasonController.text}');
              },
              child: Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
