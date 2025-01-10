import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final Function(String) onChanged;



   CustomTextfield(
      {super.key,
      required this.hint,
      this.maxLines = 1,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Material(
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xff535353),
                fontFamily: 'Lato',
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
