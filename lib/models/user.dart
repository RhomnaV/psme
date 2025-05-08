class User {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String birthDate;
  final String phone;
  final String address;
  final String chapter;
  final String sex;

  User({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.phone,
    required this.address,
    required this.chapter,
    required this.sex,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      birthDate: json['birth_date'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      chapter: json['chapter'] ?? '',
      sex: json['sex'] ?? '',
    );
  }
}
