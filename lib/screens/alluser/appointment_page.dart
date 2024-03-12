import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:http/http.dart' as http;
import '../../models/appointment.dart'; // Ensure this path is correct.

class AppointmentPage extends StatefulWidget {
  final String doctorId;

  const AppointmentPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  String _patientName = '';
  int _age = 0;
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _selectedSlot = 'Slot 1';
  String _address = '';
  String _mobileNumber = '';
  String _reason = '';

  final List<String> _slots = ['Slot 1', 'Slot 2', 'Slot 3' ,'Slot 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _patientName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number, // Set keyboard type to number
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  // Check if the entered value is a valid number
                  final age = int.tryParse(value);
                  if (age == null) {
                    return 'Please enter a valid age';
                  }
                  // Additional validation can be added here if needed
                  return null;
                },
                onSaved: (value) {
                  // Convert the value to an integer and save it
                  _age = int.parse(value!);
                },
              ),
              ListTile(
                title: Text('Appointment Date'),
                subtitle: Text(_selectedDate),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Slot'),
                value: _selectedSlot,
                items: _slots
                    .map((slot) => DropdownMenuItem(
                  child: Text(slot),
                  value: slot,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSlot = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return 'Please enter a valid 10 digit mobile number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mobileNumber = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reason for Appointment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reason for appointment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _reason = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    // Prepare appointment object
    Appointment appointment = Appointment(
      doctorId: widget.doctorId,
      date: _selectedDate,
      timeSlot: '', // Add logic to determine time slot
      slot: _selectedSlot,
      patientName: _patientName,
      patientAge: _age,
      address: _address,
      mobileNumber: _mobileNumber,
      reason: _reason,
      status: 'active',
    );

    // Convert appointment object to JSON
    Map<String, dynamic> jsonData = appointment.toJson();

    // Send POST request
    final response = await http.post(
      Uri.parse('http://127.0.0.1/appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json', // Set content type header
      },
      body: jsonEncode(jsonData), // Encode appointment data to JSON string
    );

    if (response.statusCode == 200) {
      // Appointment booked successfully
      print('Appointment booked successfully');
    } else {
      // Error occurred while booking appointment
      print('Error occurred while booking appointment');
    }
  }
}
