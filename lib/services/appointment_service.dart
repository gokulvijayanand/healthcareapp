import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/appointment.dart'; // Adjust the import path based on your project structure

class AppointmentService {
  Future<List<Appointment>> loadAppointmentsFromJson() async {
    final String response = await rootBundle.loadString("assets/data/appointments.json");
    final data = await json.decode(response) as List;
    return data.map((appointment) => Appointment.fromJson(appointment)).toList();
  }
}
