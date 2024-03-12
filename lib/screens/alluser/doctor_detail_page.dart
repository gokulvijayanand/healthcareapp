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
      body: SingleChildScrollView( // Use SingleChildScrollView for a simple scrollable layout
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
                  Text('Qualification: ${doctor.qualification}', style: TextStyle(fontSize: 18)),
                  Text('Email: ${doctor.mailid}', style: TextStyle(fontSize: 16)), // Assuming it's `email` not `mailid`
                  Text('Office No: ${doctor.officeNo}', style: TextStyle(fontSize: 16)),
                  Text('ID: ${doctor.id}', style: TextStyle(fontSize: 16)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentPage(doctor: doctor)),
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