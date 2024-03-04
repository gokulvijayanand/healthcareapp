import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart'; // Import TableCalendar
import '../models/doctor.dart'; // Import your Doctor model
import 'dart:convert';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({Key? key, required this.doctor}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late List<dynamic> appointments = [];
  final TextEditingController _reasonController = TextEditingController();
  late int totalSlots = 10;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    loadDoctorAppointments();
  }

  Future<void> loadDoctorAppointments() async {
    // Load the appointment data from the JSON file
    final String response =
    await rootBundle.loadString('assets/data/appointments.json');
    final data = json.decode(response);
    // Assuming your JSON structure has an array of appointments for each doctor ID
    final doctorAppointments = data.firstWhere(
          (item) => item['doctorId'].toString() == widget.doctor.id,
      orElse: () => {'appointments': []},
    )['appointments'];
    setState(() {
      appointments = doctorAppointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('booking Appointment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 120, // Set the desired width
              height: 80, // Set the desired height
              child: ElevatedButton(
                onPressed: () {
                  _showCalendar();
                },
                child: Text('Select Date'),
              ),
            ),
            SizedBox(height: 20), // Add space between buttons
            SizedBox(
              width: 120, // Set the desired width
              height: 80, // Set the desired height
              child: ElevatedButton(
                onPressed: () {
                  _showTimeSlots();
                },
                child: Text('Select Time'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason for Appointment',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement booking logic
                print('Selected Date: $_selectedDay');
                print('Reason: ${_reasonController.text}');
              },
              child: Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2010),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(day, _selectedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
              Navigator.pop(context); // Close the modal sheet
            },
          ),
        );
      },
    );
  }

  void _showTimeSlots() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              _buildTimeSlotButton('8:00 am - 10:00 am'),
              _buildTimeSlotButton('10:15 am - 12:00 pm'),
              _buildTimeSlotButton('1:00 pm - 3:00 pm'),
              _buildTimeSlotButton('6:00 pm - 9:00 pm'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeSlotButton(String timeSlot) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle time slot selection
          print('Selected Time Slot: $timeSlot');
        },
        child: Text(timeSlot),
      ),
    );
  }

  bool isSameDay(DateTime day1, DateTime? day2) {
    if (day2 == null) return false;
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }
}

