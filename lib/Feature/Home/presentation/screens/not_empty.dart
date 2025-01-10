import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/widgets/custom_list_view.dart';
import 'package:up_todo/Feature/Home/presentation/widgets/dropdown.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

class notEmpty_Screen extends StatefulWidget {
  const notEmpty_Screen({
    super.key,
  });

  @override
  State<notEmpty_Screen> createState() => _notEmpty_ScreenState();
}

class _notEmpty_ScreenState extends State<notEmpty_Screen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Material(
      child: BlocProvider(
        create: (_) => sl<TaskListBloc>()..add(LoadTasks()),
        child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color(0xffAFAFAF),
                            size: 24.sp,
                          ),
                          hintText: "Search for your task...",
                          hintStyle: TextStyle(
                              color: const Color(0xff535353),
                              fontFamily: 'Lato',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          //fillColor:Color(0xff363636)
                        ),
                        onChanged: (query) {
                          context.read<TaskListBloc>().add(SearchTasks(query));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const DayDropdown(),
              SizedBox(
                height: 16.h,
              ),
              const Expanded(child: TaskListWidget()),
            ]);
          },
        ),
      ),
    );
  }
}
