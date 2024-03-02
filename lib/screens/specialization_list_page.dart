import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctor.dart'; // Ensure this import is correct
import 'doctors_list_page.dart'; // Ensure this import is correct

class SpecializationListPage extends StatefulWidget {
  @override
  _SpecializationListPageState createState() => _SpecializationListPageState();
}

class _SpecializationListPageState extends State<SpecializationListPage> {
  List<String> _specializations = [];

  @override
  void initState() {
    super.initState();
    loadSpecializations();
  }

  Future<void> loadSpecializations() async {
    final String response = await rootBundle.loadString('assets/data/doctors.json');
    final List<dynamic> data = json.decode(response);
    final List<Doctor> doctors = data.map((data) => Doctor.fromJson(data)).toList();

    final uniqueSpecializations = doctors
        .map((doctor) => doctor.specialization)
        .toSet()
        .toList();

    setState(() {
      _specializations = uniqueSpecializations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Specialization'),
      ),
      body: ListView.builder(
        itemCount: _specializations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_specializations[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorsListPage(specialization: _specializations[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
