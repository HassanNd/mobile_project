

class CVModel {
  int? id; // ✅ ADD THIS

  String fullName;
  String professionalSummary;
  String technicalSkills;
  String university;
  List<String> educationLevels;
  String yearsOfExperience;
  String email;
  String linkedinUrl;
  String availability;


  CVModel({
    this.id, // ✅ ADD THIS
    this.fullName = '',
    this.professionalSummary = '',
    this.technicalSkills = '',
    this.university = '',
    List<String>? educationLevels,
    this.yearsOfExperience = '',
    this.email = '',
    this.linkedinUrl = '',
    this.availability = '',
  }) : educationLevels = educationLevels ?? [];
}
