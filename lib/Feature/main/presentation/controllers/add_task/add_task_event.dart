import 'package:equatable/equatable.dart';

import '../../../../Category/data/models/category_model.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object?> get props => [];
}

class TaskTitleChanged extends AddTaskEvent {
  final String title;

  const TaskTitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class TaskDescriptionChanged extends AddTaskEvent {
  final String description;

  const TaskDescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class TaskStartDateChanged extends AddTaskEvent {
  final DateTime startDate;

  const TaskStartDateChanged(this.startDate);

  @override
  List<Object?> get props => [startDate];
}

class TaskEndDateChanged extends AddTaskEvent {
  final DateTime? endDate;

  const TaskEndDateChanged(this.endDate);

  @override
  List<Object?> get props => [endDate];
}

class TaskCategoryChanged extends AddTaskEvent {
  final CategoryModel? category;

  const TaskCategoryChanged(
    this.category,
  );

  @override
  List<Object?> get props => [category];
}

class LoadCategories extends AddTaskEvent {
  final List<CategoryModel>? categoriesList;

  const LoadCategories([this.categoriesList = const []]);

  @override
  List<Object?> get props => [categoriesList];
}

class TaskPriorityChanged extends AddTaskEvent {
  final int priority;

  const TaskPriorityChanged(this.priority);

  @override
  List<Object?> get props => [priority];
}

class SubmitTask extends AddTaskEvent {}
