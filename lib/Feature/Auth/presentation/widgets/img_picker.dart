import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  final Function(File) onImageSelected;

  ImageUploadScreen({required this.onImageSelected});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 50.r,
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null
            ? Icon(
                Icons.account_circle,
                size: 100.sp,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
