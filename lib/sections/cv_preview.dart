import 'dart:io';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class CVPreview extends StatelessWidget {
  final CVModel cv;
  final Color accentColor;

  const CVPreview({super.key, required this.cv, required this.accentColor});

  Widget _rowItem(IconData icon, String title, String value) {
    if (value.trim().isEmpty) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: accentColor),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(text: '$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar;

    if (cv.imageBytes != null) {
      avatar = ClipOval(
        child: Image.memory(
          cv.imageBytes!,
          width: 72,
          height: 72,
          fit: BoxFit.cover,
        ),
      );
    } else if (cv.imagePath != null) {
      avatar = ClipOval(
        child: Image.file(
          File(cv.imagePath!),
          width: 72,
          height: 72,
          fit: BoxFit.cover,
        ),
      );
    } else {

      avatar = Icon(Icons.person, size: 36, color: Colors.grey[700]);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade100, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              avatar,
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cv.fullName.isEmpty ? 'Full Name' : cv.fullName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accentColor)),
                    SizedBox(height: 4),
                    Text(cv.university.isEmpty ? '' : cv.university, style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 20, thickness: 1),
          if (cv.professionalSummary.trim().isNotEmpty) ...[
            Text('Professional Summary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            SizedBox(height: 6),
            Text(cv.professionalSummary),
            SizedBox(height: 10),
          ],
          if (cv.technicalSkills.trim().isNotEmpty) ...[
            Text('Technical Skills', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            SizedBox(height: 6),
            Text(cv.technicalSkills),
            SizedBox(height: 10),
          ],
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
