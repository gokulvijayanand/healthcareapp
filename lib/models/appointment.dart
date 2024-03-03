class Appointment {
  final String doctorId;
  final String date;
  final String timeSlot;
  final String slot;
  final String patientName;
  final String reason;

  Appointment({
    required this.doctorId,
    required this.date,
    required this.timeSlot,
    required this.slot,
    required this.patientName,
    required this.reason,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorId: json['doctorId'],
      date: json['date'],
      timeSlot: json['timeSlot'],
      slot: json['slot'],
      patientName: json['patientName'],
      reason: json['reason'],
    );
  }
}
