import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/screens/task_details.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

class TitleDescrioptionEdit extends StatelessWidget {
  final TaskModel task;
  final TextEditingController? controller;

  const TitleDescrioptionEdit({super.key, required this.task, this.controller});

  @override
  Widget build(BuildContext context) {
    sl<AddedTaskData>().updatedTitle.text = task.title;
    sl<AddedTaskData>().updatedDescription.text = task.description;
    return SafeArea(
      left: true,
      right: true,
      child: BlocProvider(
        create: (context) => sl<TaskListBloc>(),
        child: BlocBuilder<TaskListBloc, TaskListState>(
            builder: (BuildContext context, TaskListState state) {
          return Container(
            height: 198.h,
            width: 360.w,
            child: Dialog(
              backgroundColor: const Color(0xff363636),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Edit Task Title",
                      style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10.h),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16.h),
                    TextField(
                      controller: sl<AddedTaskData>().updatedTitle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        //fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        context
                            .read<TaskListBloc>()
                            .add(UpdateTaskDescription(value, task));
                      },
                    ),
                    SizedBox(height: 17.h),
                    TextField(
                      controller: sl<AddedTaskData>().updatedDescription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          color: const Color(0xffAFAFAF),
                        ),
                        //fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        context
                            .read<TaskListBloc>()
                            .add(UpdateTaskDescription(value, task));
                      },
                    ),
                    SizedBox(height: 36.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
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
                        Container(
                          height: 48.h,
                          width: 153.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: const Color(0xff8687E7)),
                          child: TextButton(
                            onPressed: () {
                              String updatedTitle =
                                  sl<AddedTaskData>().updatedTitle.text;
                              String updatedDescription =
                                  sl<AddedTaskData>().updatedDescription.text;
                              // print('Updated Title: $updatedTitle');
                              // print('Updated Description: $updatedDescription');
                              context
                                  .read<TaskListBloc>()
                                  .add(UpdateTaskTitle(updatedTitle, task));
                              context.read<TaskListBloc>().add(
                                  UpdateTaskDescription(
                                      updatedDescription, task));

                              Navigator.of(context).pop();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetails(
                                    task: task.copyWith(
                                        title: updatedTitle,
                                        description: updatedDescription),
                                    id: task.id,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Edit',
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
      ),
    );
  }
}
