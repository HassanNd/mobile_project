
import 'package:flutter/material.dart';
import 'models/cv_model.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/custom_multiline_field.dart';

import 'widgets/custom_checkbox_group.dart';
import 'widgets/custom_dropdown.dart';
import 'widgets/custom_radio_group.dart';
import 'widgets/custom_button.dart';
import 'sections/cv_preview.dart';
import 'services/cv_service.dart';

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
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
      ),
      home: const CVFormPage(),
    );
  }
}

// ================= CV FORM PAGE =================
class CVFormPage extends StatefulWidget {
  const CVFormPage({super.key});

  @override
  State<CVFormPage> createState() => _CVFormPageState();
}

class _CVFormPageState extends State<CVFormPage> {
  final _nameController = TextEditingController();
  final _summaryController = TextEditingController();
  final _yearsController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedinController = TextEditingController();

  final List<String> _universities = [
    'MU', 'LIU', 'AUB', 'LAU', 'LU', 'IUL', 'USJ'
  ];
  String _selectedUniversity = '';

  final List<String> _educationOptions = [
    'Undergraduate', 'Bachelor', 'Masters', 'PhD'
  ];
  List<String> _selectedEducation = [];

  final List<String> _availabilityOptions = [
    'Remote', 'On-site', 'Hybrid'
  ];
  String _selectedAvailability = '';



  // ================= SUBMIT CV =================
  Future<void> _submitCV() async {
    CVModel cv = CVModel(
      fullName: _nameController.text.trim(),
      professionalSummary: _summaryController.text.trim(),
      technicalSkills: '',
      university: _selectedUniversity,
      educationLevels: List<String>.from(_selectedEducation),
      yearsOfExperience: _yearsController.text.trim(),
      email: _emailController.text.trim(),
      linkedinUrl: _linkedinController.text.trim(),
      availability: _selectedAvailability,
    );

    final result = await CVService.addCV(cv);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    if (result.toLowerCase().contains("success")) {
      setState(() {
        _nameController.clear();
        _summaryController.clear();
        _yearsController.clear();
        _emailController.clear();
        _linkedinController.clear();
        _selectedUniversity = '';
        _selectedEducation.clear();
        _selectedAvailability = '';

      });
    }
  }

  void _openAllCVs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AllCVsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Printer'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: _openAllCVs,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              CustomTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 12),

              CustomMultilineField(
                controller: _summaryController,
                label: 'Professional Summary',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 12),

              CustomDropdownField(
                label: 'Education University',
                value: _selectedUniversity,
                items: _universities,
                onChanged: (val) =>
                    setState(() => _selectedUniversity = val ?? ''),
              ),
              const SizedBox(height: 12),

              CustomCheckboxGroup(
                options: _educationOptions,
                selected: _selectedEducation,
                onChanged: (list) =>
                    setState(() => _selectedEducation = list),
              ),
              const SizedBox(height: 12),

              CustomRadioGroup(
                label: 'Availability',
                options: _availabilityOptions,
                value: _selectedAvailability,
                onChanged: (val) =>
                    setState(() => _selectedAvailability = val ?? ''),
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _yearsController,
                label: 'Years of Experience',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _linkedinController,
                label: 'LinkedIn URL',
                icon: Icons.link,
              ),
              const SizedBox(height: 20),

              CustomButton(
                label: 'Add CV',
                icon: Icons.save,
                onPressed: _submitCV,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= ALL CVs PAGE =================
class AllCVsPage extends StatefulWidget {
  const AllCVsPage({super.key});

  @override
  State<AllCVsPage> createState() => _AllCVsPageState();
}

class _AllCVsPageState extends State<AllCVsPage> {
  List<CVModel> cvs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCVs();
  }

  Future<void> loadCVs() async {
    final data = await CVService.getAllCVs();
    setState(() {
      cvs = data;
      loading = false;
    });
  }

  Future<void> deleteCV(int index) async {
    final result = await CVService.deleteCV(cvs[index].id!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    if (result.toLowerCase().contains("success")) {
      setState(() => cvs.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All CVs')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cvs.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    CVPreview(
                      cv: cvs[index],
                      accentColor: Colors.blueAccent,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteCV(index),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
