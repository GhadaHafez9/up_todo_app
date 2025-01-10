import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Category/data/models/category_model.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/widgets/data_picker_util.dart';
import 'package:up_todo/Feature/main/presentation/controllers/add_task/add_task_bloc.dart';
import 'package:up_todo/Feature/main/presentation/controllers/add_task/add_task_event.dart';
import 'package:up_todo/Feature/main/presentation/controllers/add_task/add_task_state.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';
import 'package:up_todo/Feature/main/presentation/widgets/cust_textfield.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

import '../../../Home/presentation/widgets/category_util.dart';
import '../../../Home/presentation/widgets/priority_util.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AddTaskBloc>()),
        BlocProvider(create: (_) => sl<TaskListBloc>()),
      ],
      child: BlocListener<AddTaskBloc, AddTaskState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == TaskStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state.status == TaskStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task added successfully!')),
            );
            context.read<TaskListBloc>().add(LoadTasks());
            sl<AddedTaskData>().titleController.clear();
            sl<AddedTaskData>().descriptionController.clear();
            Navigator.pop(context);
          } else if (state.status == TaskStatus.failure) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add task.')),
            );
          }
        },
        child: BlocBuilder<AddTaskBloc, AddTaskState>(
          builder: (context, state) {
            return Container(
              padding:  EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom+8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustTextfield(
                      hintText: 'Title',
                      controller: sl<AddedTaskData>().titleController,
                    ),
                    CustTextfield(
                      hintText: 'Description',
                      maxLines: 3,
                      controller: sl<AddedTaskData>().descriptionController,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            DateTime? selectedDate =
                                await showCalendarPopup(context);
                            if (selectedDate != null) {
                              context
                                  .read<AddTaskBloc>()
                                  .add(TaskStartDateChanged(selectedDate));
                            }
                          },
                          icon: const Icon(Icons.access_time,
                              color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () async {
                            CategoryModel? selectedCategory =
                                await showCategoryDialog(context);
                            if (selectedCategory != null) {
                              context
                                  .read<AddTaskBloc>()
                                  .add(TaskCategoryChanged(selectedCategory));
                            }
                          },
                          icon: const Icon(Icons.label_important_outline,
                              color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () async {
                            int? selectedPriority =
                                await showTaskPriorityDialog(context);
                            if (selectedPriority != null) {
                              context
                                  .read<AddTaskBloc>()
                                  .add(TaskPriorityChanged(selectedPriority));
                            }
                          },
                          icon: const Icon(Icons.flag_outlined,
                              color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            context.read<AddTaskBloc>().add(SubmitTask());
                          },
                          icon:
                              const Icon(Icons.send, color: Color(0xff8687E7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
