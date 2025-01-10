part of 'task_list_bloc.dart';

enum TaskStatusList { initial, loading, success, failure ,deleted }

class TaskListState extends Equatable {
  final String id;
  final String title;
  final DateTime startDate;
  final int? priority;
  final CategoryModel? category;
  final List<CategoryModel> categoryList;
  final List<TaskModel>? todos;
  final bool isChecked;
  final String query;
  final String filter;
  final TaskStatusList status;
  final List<TaskModel>? allTodos;

  TaskListState({
    this.id = '',
    this.title = '',
    this.priority,
    this.category,
    this.todos = const [],
    required this.isChecked,
    this.filter = "Today",
    required this.startDate,
    this.status = TaskStatusList.initial,
    this.query = '',
    this.allTodos,
    this.categoryList = const [],
  });

  TaskListState copyWith({
    String? id,
    String? title,
    int? priority,
    CategoryModel? category,
    List<TaskModel>? todos,
    bool? isChecked,
    String? filter,
    DateTime? startDate,
    TaskStatusList? status,
    String? query,
    List<TaskModel>? allTodos,
    List<CategoryModel>? categoryList,
  }) {
    return TaskListState(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      todos: todos ?? this.todos,
      isChecked: isChecked ?? this.isChecked,
      filter: filter ?? this.filter,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
      query: query ?? this.query,
      allTodos: allTodos ?? this.allTodos,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        priority,
        category,
        todos,
        isChecked,
        filter,
        startDate,
        status,
        query,
        allTodos,
        categoryList
      ];
}
