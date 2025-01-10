import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:up_todo/Feature/Auth/data/models/user.dart';
import 'package:up_todo/Feature/Auth/presentation/controllers/image_notifier.dart';
import 'package:up_todo/Feature/Auth/presentation/screens/auth_screen.dart';
import 'package:up_todo/core/cache_service/cache_service.dart';

import '../../../Auth/presentation/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  final String? username;

  const ProfileScreen({super.key, this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? userImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final newImage = File(pickedFile.path);
      setState(() {
        userImage = newImage;
      });
      final user = await CacheService().getUser();
      if (user != null) {
        await CacheService().saveUser(user.name, pickedFile.path);
      }
      ProfileImageNotifier.imageNotifier.value = newImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: CacheService().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          }

          final user = snapshot.data;
          if (user == null) {
            return Center(
              child: Text(
                'No user data available',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            );
          }

          final displayImage =
              userImage ?? (user.img != null ? File(user.img) : null);

          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60.h,
                    backgroundImage: displayImage != null
                        ? FileImage(displayImage)
                        : const AssetImage('assets/images/account.jpg')
                            as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15.sp,
                        backgroundColor: const Color(0xff8687E7),
                        child: Icon(
                          Icons.edit,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 29.h),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    'Change account name',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    Icons.person_outline,
                    size: 24.sp,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 24.sp,
                  ),
                ),
                const Spacer(),
                CustomButton(
                    buttonText: 'LogOut',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                            (Route<dynamic> route) => true,
                      );
                    }),
              ],
            ),

          );
        },
      ),
    );
  }
}
