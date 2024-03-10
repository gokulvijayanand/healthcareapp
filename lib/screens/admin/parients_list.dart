import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/appointment.dart'; // Import the Appointment class

class PatientsListPage extends StatefulWidget {
  @override
  _PatientsListPageState createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  late List<Appointment> appointments;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('YOUR_APPOINTMENTS_API_URL'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      appointments = data.map((item) => Appointment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text(appointment.patientName),
            subtitle: Text('Age: ${appointment.patientAge} - Reason: ${appointment.reason}'),
            // You can add more appointment information here
          );
        },
      ),
    );
  }
}


