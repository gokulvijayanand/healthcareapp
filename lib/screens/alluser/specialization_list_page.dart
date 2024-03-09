import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package
import '../../models/doctor.dart'; // Ensure this import is correct
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
                    _hoveredSpecialization = null;
                  });
                },
                child: Card(
                  elevation: 4, // Add elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  color: _hoveredSpecialization == specialization
                      ? Colors.deepPurple.withOpacity(0.8) // Lighter purple on hover
                      : Colors.deepPurple, // Default purple color
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorsListPage(specialization: specialization),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _buildLottieAsset(specialization), // Lottie asset
                          ),
                        ),
                        Center(
                          child: Text(
                            specialization,
                            style: TextStyle(color: Colors.white), // White text color
                          ),
                        ),
                      ],
                    ),
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

Widget _buildLottieAsset(String specialization) {
  // Default Lottie asset if specialization doesn't match any condition
  String lottieAsset = 'assets/lottie/heart_beat.json';

  // Check specialization value and assign appropriate Lottie asset
  if (specialization == 'Dermatologist') {
    lottieAsset = 'assets/lottie/doctor.json';
  } else if (specialization == 'Dentist') {
    lottieAsset = 'assets/lottie/appointments.json';
  }
  // Add more conditions as needed

  // Return Lottie asset widget
  return Lottie.asset(lottieAsset, width: 60);
}
