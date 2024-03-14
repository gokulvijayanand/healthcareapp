class Doctor {
  final int user;
  final int id;
  final String name;
  final String qualifications;
  final String specialization;
  final String image;
  final String email;
  final String office_number;
  final bool available;

  Doctor({
    required this.user,
    required this.id,
    required this.name,
    required this.qualifications,
    required this.specialization,
    required this.image,
    required this.email,
    required this.office_number,
    required this.available,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      user: json['user'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      qualifications: json['qualifications'] ?? '',
      specialization: json['specialization'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
      office_number: json['office_number'] ?? '',
      available: json['available'] ?? false,
    );
  }

  String get imageUrl => image;
}
