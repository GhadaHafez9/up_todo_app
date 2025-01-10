import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 327.w,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff8687E7).withOpacity(0.5),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: const Color(0xffFFFFFF).withOpacity(0.5),
            fontFamily: 'Lato',
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
