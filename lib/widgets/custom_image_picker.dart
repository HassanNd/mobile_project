// ignore: unnecessary_import
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:io';

class CustomImagePicker extends StatefulWidget {
  final Function(String?, Uint8List?) onImageSelected;

  const CustomImagePicker({required this.onImageSelected, super.key});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? pickedMobileImage;
  Uint8List? pickedWebImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    if (kIsWeb) {
      final Uint8List? bytes = await ImagePickerWeb.getImageAsBytes();
      if (bytes != null) {
        setState(() => pickedWebImage = bytes);
        widget.onImageSelected(null, bytes); // pass bytes for web
      }
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => pickedMobileImage = image);
        widget.onImageSelected(image.path, null); // pass path for mobile
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? avatarImage;

    if (kIsWeb && pickedWebImage != null) {
      avatarImage = MemoryImage(pickedWebImage!);
    } else if (!kIsWeb && pickedMobileImage != null) {
      avatarImage = FileImage(File(pickedMobileImage!.path));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Image",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),
        ),
        SizedBox(height: 10),
        Center(
          child: GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey[300],
              backgroundImage: avatarImage,
              child: avatarImage == null ? Icon(Icons.camera_alt, size: 40, color: Colors.black54) : null,
            ),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: TextButton(onPressed: pickImage, child: Text("Upload Image", style: TextStyle(fontSize: 14))),
        ),
      ],
    );
  }
}
