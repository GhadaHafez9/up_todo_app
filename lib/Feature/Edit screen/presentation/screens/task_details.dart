import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Category/data/models/category_model.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/widgets/category_dialog.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/widgets/confirm_deletion.dart';
import 'package:up_todo/Feature/Edit%20screen/presentation/widgets/title_descrioption_edit.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/Feature/main/presentation/screens/main_screen.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

import '../../../Home/presentation/widgets/time_fun.dart';
import '../widgets/priority_updates.dart';
import '../widgets/update_time.dart';

class TaskDetails extends StatefulWidget {
  final TaskModel task;
  final String id;

  const TaskDetails({super.key, required this.task, required this.id});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  void _DeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeletion(id: widget.id);
      },
    );
  }

  void _editTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TitleDescrioptionEdit(
          task: widget.task,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskListBloc>(),
      child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            if(state.status == TaskStatusList.deleted){
              Navigator.pop(context);
            }
            return Scaffold(
              body: SafeArea(
                top: true,
                left: true,
                child: RefreshIndicator(
                  onRefresh: () async {
                    sl<TaskListBloc>().add(RefreshTasks());
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 16, left: 14, right: 14),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 32.h,
                                  width: 32.w,
                                  color: const Color(0xff1D1D1D),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 24.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                                Container(
                                  height: 32.h,
                                  width: 32.w,
                                  color: const Color(0xff1D1D1D),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.loop_outlined,
                                        color: Colors.white,
                                        size: 24.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    widget.task.isChecked ?? false
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  onPressed: () {
                                    //context.read<TaskListBloc>().add(UpdateTask(task));
                                  },
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(widget.task.title,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato',
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(widget.task.description,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'Lato',
                                            color: const Color(0xffAFAFAF))),
                                  ],
                                ),
                                SizedBox(
                                  width: 130.w,
                                ),
                                Flexible(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: Colors.white,
                                        size: 24.sp,
                                      ),
                                      onPressed: () {
                                        _editTaskDialog(context);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        ListTile(
                            leading: Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            title: Text('Task Time:',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.normal)),
                            trailing: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.21),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                height: 37.h,
                                width: 108.w,
                                child: Center(
                                  child: Text(
                                      '${DateFormatter.formatDate(
                                          widget.task.startDate)} ',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white)),
                                )),
                            onTap: () async {
                              DateTime? updatedDate =
                              await showUpdateCalendar(context, widget.task);
                              if (updatedDate != null) {
                                context
                                    .read<TaskListBloc>()
                                    .add(UpdateDate(updatedDate, widget.task));
                              }
                            }),
                        SizedBox(
                          height: 34.h,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.label_important_outline,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          title: Text('Task Category:',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.normal)),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.21),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            height: 40.h,
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.task.category != null
                                    ? Icon(
                                  IconData(
                                    widget.task.category!.iconCodePoint,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Color(
                                      widget.task.category!.colorValueIcon!),
                                  size: 16.sp,
                                )
                                    : Container(),
                                SizedBox(width: 10.w),
                                widget.task.category != null
                                    ? Text(
                                  widget.task.category!.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                          onTap: () async {
                            CategoryModel? updatedCategory =
                            await showCategoryChangedDialog(context, widget.task);
                            if (updatedCategory != null) {
                              context.read<TaskListBloc>().add(UpdatedCategories(
                                  task: widget.task,
                                  updatedCategory: updatedCategory));
                            }
                          },
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        ListTile(
                            leading: Icon(
                              Icons.outlined_flag_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            title: Text('Task Priority:',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.normal)),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.21),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              height: 37.h,
                              width: 70.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.outlined_flag_outlined,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text('${widget.task.priority}',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white)),
                                ],
                              ),
                            ),
                            onTap: () async {
                              int? updatedPriority = await showUpdatePriorityDialog(
                                  context, widget.task);
                              if (updatedPriority != null) {
                                context.read<TaskListBloc>().add(
                                    UpdateListPriority(
                                        updatedPriority, widget.task));
                              }
                            }),
                        SizedBox(
                          height: 34.h,
                        ),
                        ListTile(
                            leading: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                            title: Text(
                              'Delete Task ',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red),
                            ),
                            onTap: () {
                              _DeleteDialog(context);
                            }),
                        const Spacer(),
                        Container(
                          height: 48.h,
                          width: 327.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              context.read<TaskListBloc>().add(RefreshTasks());

                              if (Navigator.canPop(context)) {
                                Navigator.pop(context, widget.task);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const MainScreen(),
                                  ),
                                );
                              }
                            },
                            backgroundColor: const Color(0xff8687E7),
                            child: Text('Edit Task',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
