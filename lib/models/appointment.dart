class Appointment {
  final String doctorId;
  final String date;
  final String timeSlot;
  final String slot;
  final String patientName;
  final int patientAge; // New patientAge field as int
  final String reason;
  final String status;

  Appointment({
    required this.doctorId,
    required this.date,
    required this.timeSlot,
    required this.slot,
    required this.patientName,
    required this.patientAge, // Initialize the patientAge
    required this.reason,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorId: json['doctorId'],
      date: json['date'],
      timeSlot: json['timeSlot'],
      slot: json['slot'],
      patientName: json['patientName'],
      patientAge: json['patientAge'], // Parse the patientAge from JSON
      reason: json['reason'],
      status: json['status'],
    );
  }
}
