import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/appointment.dart'; // Import the Appointment class

class PatientHistoryPage extends StatefulWidget {
  @override
  _PatientHistoryPageState createState() => _PatientHistoryPageState();
}

class _PatientHistoryPageState extends State<PatientHistoryPage> {
  late List<Appointment> appointments;
  late List<Appointment> filteredAppointments;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final response = await http.get(Uri.parse('YOUR_APPOINTMENTS_API_URL'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      appointments = data.map((item) => Appointment.fromJson(item)).toList();
      filteredAppointments = List.from(appointments);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterAppointments(String query) {
    setState(() {
      filteredAppointments = appointments
          .where((appointment) =>
      appointment.patientName.toLowerCase().contains(query.toLowerCase()) ||
          appointment.mobileNumber.contains(query)) // Include mobile number in search
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                filterAppointments(value); // Call filterAppointments method when text changes
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = filteredAppointments[index];
                return ListTile(
                  title: Text(appointment.patientName),
                  subtitle: Text('Date: ${appointment.date}, Time: ${appointment.timeSlot}, Doctor ID: ${appointment.doctorId}'),
                  // You can add more appointment information here
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

