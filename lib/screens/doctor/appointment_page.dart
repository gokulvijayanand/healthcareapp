import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import '../../models/appointment.dart'; // Add intl package for date formatting

// Assuming Appointment and Patient class definitions remain the same

Future<List<Appointment>> loadAppointmentsFromJson() async {
  final String response = await rootBundle.loadString('assets/data/appointments.json');
  final data = await json.decode(response) as List;
  return data.map((appointment) => Appointment.fromJson(appointment)).toList();
}

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late Future<List<Appointment>> appointments;
  String selectedCategory = 'today';

  @override
  void initState() {
    super.initState();
    appointments = loadAppointmentsFromJson();
  }

  void setSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // Utility function to check if a given date is today
  bool isToday(String dateString) {
    final date = DateFormat('yyyy-MM-dd').parse(dateString);
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // Utility function to check if a given date is in the future
  bool isUpcoming(String dateString) {
    final date = DateFormat('yyyy-MM-dd').parse(dateString);
    return date.isAfter(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['today', 'upcoming', 'completed', 'canceled']
                    .map((category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category.toUpperCase()),
                    selected: selectedCategory == category,
                    onSelected: (bool selected) {
                      setSelectedCategory(category);
                    },
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(color: selectedCategory == category ? Colors.white : Colors.deepPurple),
                    backgroundColor: Colors.white,
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Appointment>>(
              future: appointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  var filteredAppointments = snapshot.data!.where((appointment) {
                    switch (selectedCategory) {
                      case 'today':
                        return isToday(appointment.date) && appointment.status == 'active';
                      case 'upcoming':
                        return isUpcoming(appointment.date) && appointment.status == 'active';
                      case 'canceled':
                        return appointment.status == 'inactive'; // Assuming 'inactive' represents canceled
                      default:
                        return false;
                    }
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Appointment ID: ${filteredAppointments[index].doctorId}'),
                        subtitle: Text('Patient: ${filteredAppointments[index].patientName} - Date: ${filteredAppointments[index].date}'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Patient Details'),
                                content: Text('Name: ${filteredAppointments[index].patientName}\nAge: ${filteredAppointments[index].patientAge}'),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
