import 'package:hive/hive.dart';

import '../../../../Category/data/models/category_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? endDate;
  @HiveField(5)
  final CategoryModel? category;
  @HiveField(6)
  final int priority;
  @HiveField(7)
  bool? isChecked;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    this.category,
    required this.priority,
    this.isChecked,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    CategoryModel? category,
    bool? isChecked,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, priority, category, isChecked, startDate, description];
}
