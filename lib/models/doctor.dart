class Doctor {
  final String id;
  final String name;
  final String qualification;
  final String specialization;
  final String specialization_icon;
  final String image;
  final String mailid;
  final String officeNo;

  Doctor({
    required this.id,
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.specialization_icon,
    required this.image,
    required this.mailid,
    required this.officeNo,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      qualification: json['qualification'],
      specialization: json['specialization'],
      specialization_icon: json['specialization_icon'],
      image: json['image'],
      mailid: json['mailid'],
      officeNo: json['officeNo'],
    );
  }

  String get imageUrl => image; // Corrected getter method
}
