class Country {
  final int id;
  final String name;
  final String mobileCode;
  final String code;

  Country({
    required this.id,
    required this.name,
    required this.mobileCode,
    required this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      mobileCode: json['mobilecode'],
      code: json['code'],
    );
  }
}
