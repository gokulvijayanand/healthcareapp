import 'package:flutter/material.dart';
import '../../models/doctor.dart'; // Ensure this path is correct.
import 'appointment_page.dart'; // Update the path according to your project structure.

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(doctor.image, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${doctor.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Specialization: ${doctor.specialization}', style: TextStyle(fontSize: 20)),
                  Text('Qualifications: ${doctor.qualifications}', style: TextStyle(fontSize: 18)), // Changed to 'qualifications'
                  Text('Email: ${doctor.email}', style: TextStyle(fontSize: 16)), // Changed from 'mailid'
                  Text('Office No: ${doctor.office_number}', style: TextStyle(fontSize: 16)), // Changed from 'officeNo'
                  Text('ID: ${doctor.id}', style: TextStyle(fontSize: 16)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentPage(doctorId: doctor.id.toString())),
                      );
                    },
                    child: Text('Book Appointment'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
