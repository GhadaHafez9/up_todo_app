import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Auth/presentation/controllers/image_notifier.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/screens/empty-status.dart';
import 'package:up_todo/Feature/Home/presentation/screens/not_empty.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

import '../../../../core/cache_service/cache_service.dart';

class HomeScreen extends StatefulWidget {
  final String? userImage;

  const HomeScreen({super.key, this.userImage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? userImage;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  Future<void> _loadUserImage() async {
    final user = await CacheService().getUser();
    setState(() {
      if (user?.img != null) {
        userImage = File(user!.img);
        ProfileImageNotifier.imageNotifier.value = userImage ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
          create: (context) => sl<TaskListBloc>()..add(LoadTasks()),
          child: BlocBuilder<TaskListBloc, TaskListState>(
              builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.filter_list_outlined,
                            size: 33.sp,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          'Index',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        ValueListenableBuilder<File?>(
                            valueListenable: ProfileImageNotifier.imageNotifier,
                            builder: (context, displayImage, child) {
                              return CircleAvatar(
                                backgroundImage: displayImage != null
                                    ? FileImage(displayImage)
                                    : const AssetImage('assets/images/account.jpg')
                                as ImageProvider,
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Expanded(
                        child: state.todos?.isEmpty ?? true
                            ? const Emptystatus()
                            : const notEmpty_Screen()),
                  ],
                ));
          })),
    );
  }
}
