import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Emptystatus extends StatelessWidget {
  const Emptystatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty.png',
              width: 227.w,
              height: 227.h,
            ),
            SizedBox(height: 10.h),
            const Text(
              'What do you want to do today? \n      '
              'Tap + to add your tasks',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffFFFFFF),
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
