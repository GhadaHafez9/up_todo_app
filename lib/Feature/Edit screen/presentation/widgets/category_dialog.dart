import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:up_todo/Feature/Category/data/models/category_model.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

Future<CategoryModel?> showCategoryChangedDialog(
    BuildContext context, TaskModel task) async {
  CategoryModel? updatedCategory;

  return showDialog<CategoryModel>(
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (_) => sl<TaskListBloc>()..add(const LoadListCategories()),
        child: Dialog(
          backgroundColor: const Color(0xff363636),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            width: 327.w,
            height: 556.h,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Choose Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                  color: Color(0xff979797),
                ),
                SizedBox(height: 16.h),
                BlocBuilder<TaskListBloc, TaskListState>(
                  builder: (context, state) {
                    final categoryBox = state.categoryList;

                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 46,
                          mainAxisSpacing: 42,
                        ),
                        itemCount: categoryBox.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                updatedCategory = null;
                                context.read<TaskListBloc>().add(
                                      UpdatedCategories(
                                          updatedCategory: updatedCategory,
                                          task: task),
                                    );
                                Navigator.pop(context, null);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 64.w,
                                    height: 64.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.not_interested,
                                        size: 25.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "None",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (index == categoryBox.length + 1) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 64.w,
                                    height: 64.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff8687E7),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,
                                          size: 32.sp, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Create New",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            final category = categoryBox[index - 1];

                            return GestureDetector(
                              onTap: () {
                                updatedCategory = category;
                                context.read<TaskListBloc>().add(
                                      UpdatedCategories(
                                        task: task,
                                        updatedCategory: updatedCategory,
                                      ),
                                    );
                                Navigator.pop(context, updatedCategory);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 64.w,
                                    height: 64.h,
                                    decoration: BoxDecoration(
                                      color: Color(category.colorBg),
                                      border: Border.all(
                                        color: updatedCategory == category
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        IconData(
                                          category.iconCodePoint,
                                          fontFamily: category.iconFontFamily,
                                          fontPackage: category.iconFontPackage,
                                        ),
                                        color: Color(category.colorValueIcon!),
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
