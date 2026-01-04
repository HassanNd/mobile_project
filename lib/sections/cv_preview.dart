import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class CVPreview extends StatelessWidget {
  final CVModel cv;
  final Color accentColor;

  const CVPreview({
    super.key,
    required this.cv,
    required this.accentColor,
  });

  Widget _rowItem(IconData icon, String title, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: accentColor),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade100, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ===== HEADER (ICON + NAME + UNIVERSITY) =====
          Row(
            children: [
              Icon(Icons.person, size: 40, color: accentColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cv.fullName.isEmpty ? 'Full Name' : cv.fullName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cv.university,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 20, thickness: 1),

          // ===== PROFESSIONAL SUMMARY =====
          if (cv.professionalSummary.trim().isNotEmpty) ...[
            const Text(
              'Professional Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 6),
            Text(cv.professionalSummary),
            const SizedBox(height: 10),
          ],

          // ===== TECHNICAL SKILLS =====
          if (cv.technicalSkills.trim().isNotEmpty) ...[
            const Text(
              'Technical Skills',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 6),
            Text(cv.technicalSkills),
            const SizedBox(height: 10),
          ],

          // ===== OTHER INFO =====
          _rowItem(Icons.school, 'Education', cv.educationLevels.join(', ')),
          _rowItem(Icons.work, 'Years of Experience', cv.yearsOfExperience),
          _rowItem(Icons.location_on, 'Availability', cv.availability),
          _rowItem(Icons.email, 'Email', cv.email),
          _rowItem(Icons.link, 'LinkedIn', cv.linkedinUrl),
        ],
      ),
    );
  }
}
