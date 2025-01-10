import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Auth/presentation/controllers/sign_up_bloc.dart';
import 'package:up_todo/Feature/Auth/presentation/widgets/custom_button.dart';
import 'package:up_todo/Feature/Auth/presentation/widgets/custom_textfield.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';
import 'package:up_todo/Feature/main/presentation/screens/main_screen.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

import '../widgets/img_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  File? userImage;

  void _handleImageSelection(File image) {
    setState(() {
      userImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      body:  SingleChildScrollView(
        child: BlocProvider(
          create: (_) => sl<SignUpBloc>(),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.status == SignUpStatus.success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              } else if (state.status == SignUpStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? 'Sign up failed')),
                );
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            "Sign In ",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      SizedBox(height: 20.h),
                      ImageUploadScreen(onImageSelected: _handleImageSelection),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 270, bottom: 10),
                        child: Text(
                          "Username",
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      CustomTextfield(
                        hint: 'Enter your Username ',
                        controller: sl<AddedTaskData>().nameController,
                        onChanged: (email) {
                          context.read<SignUpBloc>().add(SignUpEmailChanged(email));
                        },
                      ),
                      SizedBox(
                        height: 114.h,
                      ),
                      CustomButton(
                          buttonText: 'Sign in',
                          onTap: () {
                            final username =
                                sl<AddedTaskData>().nameController.text;
                            final userImagePath = userImage?.path;

                            if (username.isNotEmpty) {
                              context
                                  .read<SignUpBloc>()
                                  .add(SaveUserData(username, userImagePath));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please enter a username')),
                              );
                            }
                          }),
                      SizedBox(
                        height: 31.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 44.h,
                      ),
                      CustomButton(
                          buttonText: 'Discord',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
