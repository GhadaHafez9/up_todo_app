import 'package:equatable/equatable.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';

import '../../../../Category/data/models/category_model.dart';

enum TaskStatus { initial, loading, success, failure }

class AddTaskState extends Equatable {
  final String id;

  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final CategoryModel? category;
  final List<CategoryModel> categoryList;
  final int priority;
  final bool isChecked;
  final List<TaskModel> tasks;
  final TaskStatus status;

  const AddTaskState(
      {this.id = '',
      this.title = '',
      this.description = '',
      required this.startDate,
      this.endDate,
      this.category,
      this.categoryList = const [],
      this.priority = 0,
      required this.isChecked,
      this.tasks = const [],
      this.status = TaskStatus.initial});

  AddTaskState copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    CategoryModel? category,
    List<CategoryModel>? categoryList,
    int? priority,
    bool? isChecked,
    List<TaskModel>? tasks,
    TaskStatus? status,
  }) {
    return AddTaskState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      categoryList: categoryList ?? this.categoryList,
      priority: priority ?? this.priority,
      isChecked: isChecked ?? this.isChecked,
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        category,
        categoryList,
        priority,
        isChecked,
        tasks,
        status
      ];
}
