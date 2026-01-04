// lib/sections/all_cvs_page.dart
import 'package:flutter/material.dart';
import '../models/cv_model.dart';
import '../services/cv_service.dart';
import 'cv_preview.dart';

class AllCVsPage extends StatefulWidget {
  const AllCVsPage({super.key});

  @override
  State<AllCVsPage> createState() => _AllCVsPageState();
}

class _AllCVsPageState extends State<AllCVsPage> {
  List<CVModel> _cvs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCVs();
  }

  void _fetchCVs() async {
    setState(() => _loading = true);
    _cvs = await CVService.getAllCVs();
    setState(() => _loading = false);
  }

  void _deleteCV(int index) async {
    int idToDelete = index; // replace this if your CVModel stores database ID

    String res = await CVService.deleteCV(idToDelete);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));

    // remove from local list
    setState(() {
      _cvs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All CVs'), centerTitle: true),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _cvs.isEmpty
          ? const Center(child: Text('No CVs found'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _cvs.length,
              itemBuilder: (context, index) {
                final cv = _cvs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      CVPreview(cv: cv, accentColor: Colors.blueAccent),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCV(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
