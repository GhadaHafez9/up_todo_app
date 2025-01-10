import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';

class DayDropdown extends StatefulWidget {
  const DayDropdown({super.key});

  @override
  _DayDropdownState createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 240),
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: const Color(0xff363636),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: DropdownButton<String>(
              underline: Container(),
              value: selectedFilter,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFilter = newValue;
                  });
                  context.read<TaskListBloc>().add(FilterTodos(newValue));
                }
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    'Select filter',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'all',
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'completed',
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'not completed',
                  child: Text(
                    'Not Completed',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
