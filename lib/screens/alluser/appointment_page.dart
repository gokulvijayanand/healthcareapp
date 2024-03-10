import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/doctor.dart';
import '../../models/appointment.dart'; // Import the Appointment class
import 'dart:convert';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({Key? key, required this.doctor}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late List<Appointment> appointments = [];
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _timeSlotController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _patientAgeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late String _selectedTimeSlot; // Add this variable to hold the selected time slot

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
      appointments = doctorAppointments
          .map((item) => Appointment.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Appointment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 120,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  _showCalendar();
                },
                child: Text('Select Date'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 120,
              height: 80,
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
                controller: _patientNameController,
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _patientAgeController,
                decoration: InputDecoration(
                  labelText: 'Patient Age',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
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
                confirmAppointment();
              },
              child: Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void confirmAppointment() {
    String slot = '';

    if (_selectedTimeSlot == '8:00 am - 10:00 am') {
      slot = '1';
    } else if (_selectedTimeSlot == '10:15 am - 12:00 pm') {
      slot = '2';
    } else if (_selectedTimeSlot == '1:00 pm - 3:00 pm') {
      slot = '3';
    } else if (_selectedTimeSlot == '6:00 pm - 9:00 pm') {
      slot = '4';
    }

    final appointment = Appointment(
      doctorId: widget.doctor.id,
      date: _selectedDay.toString(), // Assuming _selectedDay is the selected date from the calendar
      timeSlot: _selectedTimeSlot,
      patientName: _patientNameController.text,
      patientAge: int.parse(_patientAgeController.text),
      address: _addressController.text,
      mobileNumber: _mobileNumberController.text,
      reason: _reasonController.text,
      status: 'active',
      slot: slot,
    );

    // Add the appointment to the list of appointments
    setState(() {
      appointments.add(appointment);
    });

    // Save the updated appointments list to the JSON file
    // Here, you would typically update your backend server with the new appointment
    // For simplicity, we'll just print the JSON representation of the appointment
    print(json.encode(appointment));

    // Clear the form fields
    _patientNameController.clear();
    _dateController.clear();
    _patientAgeController.clear();
    _addressController.clear();
    _mobileNumberController.clear();
    _reasonController.clear();
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
              Navigator.pop(context);
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
          _timeSlotController.text = timeSlot;
          _selectedTimeSlot = timeSlot; // Update the selected time slot
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
