import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

Future<int?> showUpdatePriorityDialog(BuildContext context, TaskModel task) {
  int? updatedPriority;

  return showDialog<int>(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (_) => sl<TaskListBloc>(),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 327.w,
              height: 360.h,
              child: Dialog(
                backgroundColor: const Color(0xff363636),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Task Priority",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        color: Color(0xff979797),
                      ),
                      SizedBox(height: 22.h),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                updatedPriority = index + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: updatedPriority == index + 1
                                    ? const Color(0xff8687E7)
                                    : const Color(0xff272727),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flag,
                                    color: updatedPriority == index + 1
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: updatedPriority == index + 1
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: const Color(0xff8687E7),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Lato'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (updatedPriority != null) {
                                context.read<TaskListBloc>().add(
                                      UpdateListPriority(
                                          updatedPriority!, task),
                                    );
                              }
                              Navigator.pop(context, updatedPriority);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8687E7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Text("Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Lato')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
