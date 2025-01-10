import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/screens/task_details.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/widgets/custom_list_view.dart';
import 'package:up_todo/Feature/main/presentation/screens/main_screen.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

class ConfirmDeletion extends StatelessWidget {
  final String id;

  const ConfirmDeletion({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskListBloc>(),
      child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (BuildContext context, TaskListState state) {
        return Dialog(
          backgroundColor: const Color(0xff363636),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          child: Container(
            width: 500.w,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Delete Task",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Center(
                    child: Text(
                      'Are You sure you want to \n '
                      '     delete this task?',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xff8687E7)),
                          ),
                        ),
                      ),
                      Container(
                        height: 48.h,
                        width: 153.w,
                        decoration: BoxDecoration(
                          color: const Color(0xff8687E7),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            context.read<TaskListBloc>().add(DeleteTask(id));
                            await Future.delayed(const Duration(milliseconds: 100));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen()
                              ),
                            );                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
