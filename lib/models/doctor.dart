class Doctor {
  final String name;
  final String qualification;
  final String specialization;
  final String image;
  final String mailid;
  final String officeNo;

  Doctor({
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.image,
    required this.mailid,
    required this.officeNo,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      qualification: json['qualification'],
      specialization: json['specialization'],
      image: json['image'],
      mailid: json['mailid'],
      officeNo: json['officeNo'],
    );
  }
}
