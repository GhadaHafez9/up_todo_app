import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;

  const CustTextfield(
      {super.key,
      required this.hintText,
      this.maxLines,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey[500],
            fontFamily: 'Lato',
            fontWeight: FontWeight.normal),
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
