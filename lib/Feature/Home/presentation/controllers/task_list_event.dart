part of 'task_list_bloc.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskListEvent {}

class AddTask extends TaskListEvent {
  final TaskModel task;

  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskListEvent {
  final TaskModel task;

  const UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

class SearchTasks extends TaskListEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterTodos extends TaskListEvent {
  final String filter;

  FilterTodos(this.filter);

  @override
  List<Object?> get props => [filter];
}

class DeleteTask extends TaskListEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateTaskStatus extends TaskListEvent {
  final TaskModel task;

  const UpdateTaskStatus(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskTitle extends TaskListEvent {
  final String newTitle;
  final TaskModel task;

  const UpdateTaskTitle(this.newTitle, this.task);

  @override
  List<Object?> get props => [newTitle, task];
}

class UpdateTaskDescription extends TaskListEvent {
  final String newDescription;
  final TaskModel task;

  const UpdateTaskDescription(this.newDescription, this.task);

  @override
  List<Object?> get props => [newDescription, task];
}

class LoadListCategories extends TaskListEvent {
  final List<CategoryModel>? categoriesList;

  const LoadListCategories([this.categoriesList = const []]);

  @override
  List<Object?> get props => [categoriesList];
}

class UpdatedCategories extends TaskListEvent {
  final CategoryModel? updatedCategory;
  final TaskModel task;

  const UpdatedCategories({
    required this.task,
    required this.updatedCategory,
  });

  @override
  List<Object?> get props => [updatedCategory, task];
}

class UpdateListPriority extends TaskListEvent {
  final int updatedPriority;
  final TaskModel task;

  const UpdateListPriority(this.updatedPriority, this.task);
}

class UpdateDate extends TaskListEvent {
  final DateTime updatedDate;
  final TaskModel task;

  const UpdateDate(this.updatedDate, this.task);

  @override
  List<Object?> get props => [updatedDate, task];
}

class RefreshTasks extends TaskListEvent {
  @override
  List<Object?> get props => [];
}
