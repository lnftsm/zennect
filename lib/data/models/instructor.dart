import 'class.dart';

class Instructor {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String biography;
  final List<String> specializations;
  final List<String> certifications;
  final List<ClassCategory> specialties;
  final int experienceYears;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Instructor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.biography,
    this.specializations = const [],
    this.certifications = const [],
    this.specialties = const [],
    required this.experienceYears,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      biography: json['biography'],
      specializations: List<String>.from(json['specializations'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
      specialties:
          (json['specialties'] as List?)
              ?.map(
                (s) => ClassCategory.values.firstWhere(
                  (e) => e.toString().split('.').last == s,
                ),
              )
              .toList() ??
          [],
      experienceYears: json['experienceYears'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'biography': biography,
      'specializations': specializations,
      'certifications': certifications,
      'specialties': specialties
          .map((s) => s.toString().split('.').last)
          .toList(),
      'experienceYears': experienceYears,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';

  bool get canTeachPilates => specialties.contains(ClassCategory.pilates);
  bool get canTeachYoga => specialties.contains(ClassCategory.yoga);
  bool get canTeachMeditation => specialties.contains(ClassCategory.meditation);

  Instructor copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? biography,
    List<String>? specializations,
    List<String>? certifications,
    List<ClassCategory>? specialties,
    int? experienceYears,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Instructor(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      biography: biography ?? this.biography,
      specializations: specializations ?? this.specializations,
      certifications: certifications ?? this.certifications,
      specialties: specialties ?? this.specialties,
      experienceYears: experienceYears ?? this.experienceYears,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
