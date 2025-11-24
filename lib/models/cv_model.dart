import 'dart:typed_data';

class CVModel {
  String fullName;
  String professionalSummary;
  String technicalSkills;
  String university;
  List<String> educationLevels;
  String yearsOfExperience;
  String email;
  String linkedinUrl;
  String availability;
  String? imagePath;      // mobile path
  Uint8List? imageBytes;  // web image bytes

  CVModel({
    this.fullName = '',
    this.professionalSummary = '',
    this.technicalSkills = '',
    this.university = '',
    List<String>? educationLevels,
    this.yearsOfExperience = '',
    this.email = '',
    this.linkedinUrl = '',
    this.availability = '',
    this.imagePath,
    this.imageBytes,
  }) : educationLevels = educationLevels ?? [];
}
