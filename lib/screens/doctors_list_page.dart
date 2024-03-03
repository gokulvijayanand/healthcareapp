import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctor.dart';
import 'doctor_detail_page.dart'; // Ensure this import is correct

class DoctorsListPage extends StatefulWidget {
  final String? specialization;

  DoctorsListPage({this.specialization});

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<Doctor> _doctors = [];

  @override
  void initState() {
    super.initState();
    loadDoctorsData();
  }

  Future<void> loadDoctorsData() async {
    final String response = await rootBundle.loadString('assets/data/doctors.json');
    final List<dynamic> data = json.decode(response);
    List<Doctor> loadedDoctors = data.map((data) => Doctor.fromJson(data)).toList();

    if (widget.specialization != null) {
      loadedDoctors = loadedDoctors
          .where((doctor) => doctor.specialization == widget.specialization)
          .toList();
    }

    setState(() {
      _doctors = loadedDoctors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.specialization ?? 'Doctors'),
      ),
      body: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (context, index) {
          final doctor = _doctors[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 25,
              backgroundImage: AssetImage(doctor.image),
              ),
              //Image.asset(doctor.image, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(doctor.name),
              subtitle: Text('${doctor.specialization}, ${doctor.qualification}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorDetailPage(doctor: doctor)),
              ),
            ),
          );
        },
      ),
    );
  }
}
