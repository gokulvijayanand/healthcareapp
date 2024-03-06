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
  String? _hoveredSpecialization;

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
      body: SingleChildScrollView(
        physics: ScrollPhysics(), // Enables scrolling
        padding: EdgeInsets.all(20.0), // Adds space around the GridView
        child: GridView.count(
          shrinkWrap: true, // wrap content tightly
          crossAxisCount: 2,
          children: _specializations.map((specialization) {
            return Padding(
              padding: EdgeInsets.all(1.0), // Adds space between the cards
              child: MouseRegion(
                onEnter: (event) {
                  setState(() {
                    // Change color on hover
                    _hoveredSpecialization = specialization;
                  });
                },

                onExit: (event) {
                  setState(() {
                    _hoveredSpecialization = Colors.white as String?;
                  });
                },
                child: Card(
                  elevation: 4, // Add elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  color: _hoveredSpecialization == specialization
                      ? Colors.purple.withOpacity(0.8) // Lighter purple on hover
                      : Colors.purple, // Default purple color
                  child: ListTile(
                    leading: Icon(Icons.medical_services, color: Colors.white), // Icon
                    title: Center(
                      child: Text(
                        specialization,
                        style: TextStyle(color: Colors.white), // White text color
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DoctorsListPage(specialization: specialization),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
