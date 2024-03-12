class Appointment {
  final String doctorId;
  final String slot;
  final String patientName;
  final String timeSlot;
  final String date;
  final int patientAge; // New patientAge field as int
  final String address;
  final String mobileNumber; // New mobileNumber field
  final String reason;
  final String status;

  Appointment({
    required this.doctorId,
    required this.date,
    required this.timeSlot,
    required this.slot,
    required this.patientName,
    required this.patientAge,
    required this.address, // Initialize the address
    required this.mobileNumber, // Initialize the mobileNumber
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
      patientAge: json['patientAge'],
      address: json['address'], // Parse the address from JSON
      mobileNumber: json['mobileNumber'], // Parse the mobileNumber from JSON
      reason: json['reason'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'date': date,
      'timeSlot': timeSlot,
      'slot': slot,
      'patientName': patientName,
      'patientAge': patientAge,
      'address': address,
      'mobileNumber': mobileNumber,
      'reason': reason,
      'status': status,
    };
  }
}
