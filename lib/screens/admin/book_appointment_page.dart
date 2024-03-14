import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/doctor.dart';
import '../../models/appointment.dart';

class BookAppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<BookAppointmentPage> {
  late List<Doctor> doctors;
  late List<Appointment> appointments;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
    fetchAppointments();
  }

  Future<void> fetchDoctors() async {
    final response = await http.get(Uri.parse('YOUR_DOCTORS_API_URL'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      doctors = data.map((item) => Doctor.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<void> fetchAppointments() async {
    final response = await http.get(Uri.parse('YOUR_APPOINTMENTS_API_URL'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      appointments = data.map((item) => Appointment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  List<Appointment> getAppointmentsForDoctor(String doctorId) {
    return appointments.where((appointment) => appointment.doctorId == doctorId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialization),
            onTap: () {
              List<Appointment> doctorAppointments = getAppointmentsForDoctor(doctor.id.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorAppointmentsPage(doctor: doctor, appointments: doctorAppointments),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DoctorAppointmentsPage extends StatelessWidget {
  final Doctor doctor;
  final List<Appointment> appointments;

  DoctorAppointmentsPage({required this.doctor, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments for ${doctor.name}'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text('Patient: ${appointment.patientName}'),
            subtitle: Text('Date: ${appointment.date}, Time: ${appointment.timeSlot}'),
          );
        },
      ),
    );
  }
}
