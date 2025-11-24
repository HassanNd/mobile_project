import 'package:flutter/material.dart';
import 'models/cv_model.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/custom_multiline_field.dart';
import 'widgets/custom_image_picker.dart';
import 'widgets/custom_checkbox_group.dart';
import 'widgets/custom_dropdown.dart';
import 'widgets/custom_radio_group.dart';
import 'widgets/custom_button.dart';
import 'sections/cv_preview.dart';
import 'dart:typed_data';
import 'dart:io';

void main() {
  runApp(const CVPrinterApp());
}

class CVPrinterApp extends StatelessWidget {
  const CVPrinterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Printer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(backgroundColor: Colors.blueAccent),
      ),
      home: const CVFormPage(),
    );
  }
}

class CVFormPage extends StatefulWidget {
  const CVFormPage({super.key});

  @override
  State<CVFormPage> createState() => _CVFormPageState();
}

class _CVFormPageState extends State<CVFormPage> {
  final _nameController = TextEditingController();
  final _summaryController = TextEditingController();
  final _skillsController = TextEditingController();
  final _yearsController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedinController = TextEditingController();

  final List<String> _universities = ['MU','LIU','AUB','LAU','LU','IUL','USJ'];
  String _selectedUniversity = '';
  final List<String> _educationOptions = ['Undergraduate','Bachelor','Masters','PhD'];
  List<String> _selectedEducation = [];
  final List<String> _availabilityOptions = ['Remote','On-site','Hybrid'];
  String _selectedAvailability = '';
  String? _imagePath;
  Uint8List? _imageBytes;
  CVModel _cv = CVModel();

  bool _showForm = true;

  void _onPickImage(String? path, Uint8List? bytes){
    _imagePath = path;
    _imageBytes = bytes;
  }

  void _onPrintCV(){
    setState(() {
      _cv = CVModel(
        fullName: _nameController.text.trim(),
        professionalSummary: _summaryController.text.trim(),
        technicalSkills: _skillsController.text.trim(),
        university: _selectedUniversity,
        educationLevels: List<String>.from(_selectedEducation),
        yearsOfExperience: _yearsController.text.trim(),
        email: _emailController.text.trim(),
        linkedinUrl: _linkedinController.text.trim(),
        availability: _selectedAvailability,
        imagePath: _imagePath,
        imageBytes: _imageBytes,
      );
      _showForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CV Printer'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showForm) ...[
                CustomImagePicker(onImageSelected: _onPickImage),
                SizedBox(height: 12),
                CustomTextField(controller: _nameController, label: 'Full Name', icon: Icons.person),
                SizedBox(height: 12),
                CustomMultilineField(controller: _summaryController, label: 'Professional Summary', icon: Icons.description, maxLines: 3),
                SizedBox(height: 12),
                CustomMultilineField(controller: _skillsController, label: 'Technical Skills', icon: Icons.code, maxLines: 3),
                SizedBox(height: 12),
                CustomDropdownField(label: 'Education University', value: _selectedUniversity, items: _universities, onChanged: (val)=>setState(()=>_selectedUniversity=val??'')),
                SizedBox(height: 12),
                CustomCheckboxGroup(options: _educationOptions, selected: _selectedEducation, onChanged: (list)=>setState(()=>_selectedEducation=list)),
                SizedBox(height: 12),
                CustomRadioGroup(label: 'Availability', options: _availabilityOptions, value: _selectedAvailability, onChanged: (val)=>setState(()=>_selectedAvailability=val??'')),
                SizedBox(height: 12),
                CustomTextField(controller: _yearsController, label: 'Years of Experience', icon: Icons.timer, keyboardType: TextInputType.number),
                SizedBox(height: 12),
                CustomTextField(controller: _emailController, label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress),
                SizedBox(height: 12),
                CustomTextField(controller: _linkedinController, label: 'LinkedIn URL', icon: Icons.link),
                SizedBox(height: 18),
                CustomButton(label: 'Print CV', icon: Icons.print, onPressed: _onPrintCV),
              ] else ...[
                CVPreview(cv: _cv, accentColor: Colors.blueAccent),
                SizedBox(height: 12),
                CustomButton(label: 'Back to Edit', icon: Icons.edit, onPressed: ()=>setState(()=>_showForm=true)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
