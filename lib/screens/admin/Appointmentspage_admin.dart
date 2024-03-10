import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/doctor.dart'; // Importing Doctor class from doctor.dart

class AppointmentPageAdmin extends StatefulWidget {
  @override
  _AppointmentPageAdminState createState() => _AppointmentPageAdminState();
}

class _AppointmentPageAdminState extends State<AppointmentPageAdmin> {
  late List<Doctor> doctors;
  late List<Doctor> filteredDoctors;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('YOUR_JSON_API_URL'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      doctors = data.map((item) => Doctor.fromJson(item)).toList();
      filteredDoctors = List.from(doctors);
    } else {
      throw Exception('Failed to load data');
    }

    setState(() {
      isLoading = false;
    });
  }

  void filterDoctors(bool available) {
    setState(() {
      filteredDoctors = doctors.where((doctor) => doctor.available == available).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Availability'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => filterDoctors(true),
                child: Text('Available'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => filterDoctors(false),
                child: Text('Not Available'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (BuildContext context, int index) {
                final doctor = filteredDoctors[index];
                return ListTile(
                  title: Text(doctor.name),
                  subtitle: Text(doctor.specialization),
                  // Display other doctor information as needed
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doctor.imageUrl),
                  ),
                  trailing: Icon(
                    doctor.available ? Icons.check_circle : Icons.cancel,
                    color: doctor.available ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


