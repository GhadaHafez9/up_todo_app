import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/screens/task_details.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/widgets/time_fun.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          if (state.status == TaskStatusList.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == TaskStatusList.failure) {
            return const Center(child: Text('Failed to load tasks.'));
          } else if (state.status == TaskStatusList.success ) {
            return RefreshIndicator(
                onRefresh: () async {
                  print('Refresh....');
                  context.read<TaskListBloc>().add(RefreshTasks());
             },
            child: ListView.builder(
              itemCount: state.todos?.length ?? 0,
              itemBuilder: (context, index) {
                final task = state.todos![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskDetails(
                                task: task,
                                id: task.id,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      width: 327.w,
                      height: 72.h,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xff363636),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              task.isChecked ?? false
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            onPressed: () {
                              context.read<TaskListBloc>().add(UpdateTask(task));
                            },
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        DateFormatter.formatDate(task.startDate),
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.sp,
                                          fontFamily: 'Lato',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: task.category?.colorBg != null
                                                ? Color(task.category!.colorBg)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              task.category != null
                                                  ? Icon(
                                                      IconData(
                                                        task.category!
                                                            .iconCodePoint,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      ),
                                                      color: Color(task.category!
                                                          .colorValueIcon!),
                                                      size: 16.sp,
                                                    )
                                                  : Container(),
                                              SizedBox(width: 4.w),
                                              task.category != null
                                                  ? Text(
                                                      task.category!.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.sp,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Container(
                                          width: 42.w,
                                          height: 29.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 7.5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            border: Border.all(
                                                color: const Color(0xff8687E7)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Icon(
                                                  Icons.flag_outlined,
                                                  size: 14.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                '${task.priority}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Lato',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
