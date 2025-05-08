class Chapter {
  final int id;
  final String description;
  final String? createdAt;
  final String? updatedAt;
  final int? updatedBy;
  final int isActive;
  final String regionId;
  final int chapterRegionId;
  final String? name;
  final String? email;
  final String? year;

  Chapter({
    required this.id,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    required this.isActive,
    required this.regionId,
    required this.chapterRegionId,
    this.name,
    this.email,
    this.year,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      isActive: json['is_active'],
      regionId: json['region_id'],
      chapterRegionId: json['chapter_region_id'],
      name: json['name'],
      email: json['email'],
      year: json['year'],
    );
  }
}
