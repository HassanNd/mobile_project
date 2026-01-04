import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cv_model.dart';

const String baseURL = 'http://mobilehassanproject.atwebpages.com';

class CVService {

  // ---------- GET ----------
  static Future<List<CVModel>> getAllCVs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/get_cvs.php'),
      );

      if (response.statusCode != 200) return [];

      final List data = jsonDecode(response.body);

      return data.map((cv) => CVModel(
        id: int.parse(cv['id'].toString()),
        fullName: cv['full_name'],
        professionalSummary: cv['professional_summary'],
        technicalSkills: cv['technical_skills'],
        university: cv['university'],
        educationLevels: cv['education_level']
            .toString()
            .split(',')
            .map((e) => e.trim())
            .toList(),
        yearsOfExperience: cv['experience_years'].toString(),
        email: cv['email'],
        linkedinUrl: cv['linkedin_url'],
        availability: cv['availability'],
      )).toList();

    } catch (e) {
      print(e);
      return [];
    }
  }

  // ---------- ADD ----------
  static Future<String> addCV(CVModel cv) async {
    final response = await http.post(
      Uri.parse('$baseURL/add_cv.php'),
      body: {
        "full_name": cv.fullName,
        "professional_summary": cv.professionalSummary,
        "technical_skills": cv.technicalSkills,
        "university": cv.university,
        "education_level": cv.educationLevels.join(', '),
        "experience_years": cv.yearsOfExperience,
        "email": cv.email,
        "linkedin": cv.linkedinUrl,
        "availability": cv.availability,
      },
    );

    return response.body;
  }

  // ---------- DELETE ----------
  static Future<String> deleteCV(int id) async {
    final response = await http.post(
      Uri.parse('$baseURL/delete_cv.php'),
      body: {"id": id.toString()},
    );

    return response.body;
  }
}
