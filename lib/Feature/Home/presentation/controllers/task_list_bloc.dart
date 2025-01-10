import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:up_todo/Feature/Category/data/models/category_model.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/core/cache_service/cache_service.dart';

import '../../../Category/presentation/widgets/category_fun.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc()
      : super(TaskListState(
            isChecked: false, todos: const [], startDate: DateTime.now())) {
    on<LoadTasks>(onLoadTasks);
    on<UpdateTask>(onUpdateTasks);
    on<FilterTodos>(onFilterTodos);
    on<SearchTasks>(onSearchTasks);
    on<DeleteTask>(onDeleteTasks);
    on<UpdateTaskTitle>(onUpdateTaskTitle);
    on<UpdateTaskDescription>(onUpdateTaskDescription);
    on<UpdatedCategories>(onUpdatedCategories);
    on<LoadListCategories>(onLoadListCategories);
    on<UpdateListPriority>(onUpdateListPriority);
    on<UpdateDate>(onUpdateDate);
    on<RefreshTasks>(onRefreshTasks);
  }

  void onLoadTasks(LoadTasks event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));
    try {
      final list = await CacheService().getAllTasks();
      emit(state.copyWith(
          status: TaskStatusList.success, todos: list, allTodos: list));
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onUpdateTasks(UpdateTask event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask =
          event.task.copyWith(isChecked: !(event.task.isChecked ?? false));
      await CacheService().addTask(state.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();

      emit(state.copyWith(status: TaskStatusList.success, todos: updatedList));
    } catch (error) {
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onFilterTodos(FilterTodos event, Emitter<TaskListState> emit) async {
    final filteredTasks = state.allTodos?.where((task) {
      final isChecked = task.isChecked ?? false;

      if (event.filter == 'completed') {
        return isChecked;
      } else if (event.filter == 'not completed') {
        return isChecked ? false : true;
      }
      return true;
    }).toList();

    emit(state.copyWith(todos: filteredTasks, filter: event.filter));
  }

  void onSearchTasks(SearchTasks event, Emitter<TaskListState> emit) {
    final allTodos = state.allTodos ?? [];
    if (event.query.isEmpty) {
      emit(state.copyWith(todos: allTodos));
      return;
    }

    final searchTasks = allTodos.where((task) {
      return task.title
          .toLowerCase()
          .trim()
          .contains(event.query.toLowerCase().trim());
    }).toList();

    emit(state.copyWith(todos: searchTasks));
  }

  void onDeleteTasks(DeleteTask event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));
    try {
      await CacheService().deleteTaskById(event.id);
      final updatedList = await CacheService().getAllTasks();

      emit(state.copyWith(status: TaskStatusList.deleted, todos: updatedList));
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onUpdateTaskTitle(
      UpdateTaskTitle event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask = event.task.copyWith(title: event.newTitle);
      await CacheService().addTask(updatedTask.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();

      emit(state.copyWith(status: TaskStatusList.success, todos: updatedList));
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onUpdateTaskDescription(
      UpdateTaskDescription event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask =
          event.task.copyWith(description: event.newDescription);
      await CacheService().addTask(updatedTask.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();

      emit(state.copyWith(status: TaskStatusList.success, todos: updatedList));
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onUpdatedCategories(
      UpdatedCategories event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask = event.task.copyWith(category: event.updatedCategory);
      await CacheService().addTask(updatedTask.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();

      emit(state.copyWith(
        status: TaskStatusList.success,
        todos: updatedList,
        category: event.updatedCategory,
      ));
      print('Category updated to ${event.updatedCategory}');
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onLoadListCategories(
      LoadListCategories event, Emitter<TaskListState> emit) async {
    final category = await CacheService().getAllCategories();
    if (category.isEmpty) {
      print('using default categories');
      category.addAll(generateCategories());
    } else {
      print('Categories: ${category.length}');
    }
    emit(state.copyWith(categoryList: category));
  }

  void onUpdateListPriority(
      UpdateListPriority event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask = event.task.copyWith(priority: event.updatedPriority);
      await CacheService().addTask(updatedTask.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();
      emit(state.copyWith(
        status: TaskStatusList.success,
        todos: updatedList,
      ));

      print('Priority updated to ${event.updatedPriority}');
    } catch (error) {
      print('Error updating priority: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onUpdateDate(UpdateDate event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));

    try {
      final updatedTask = event.task.copyWith(startDate: event.updatedDate);
      await CacheService().addTask(updatedTask.id, updatedTask);

      final updatedList = await CacheService().getAllTasks();
      emit(state.copyWith(
        status: TaskStatusList.success,
        todos: updatedList,
      ));

      print('Due date updated to ${event.updatedDate.toIso8601String()}');
    } catch (error) {
      print('Error updating due date: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }

  void onRefreshTasks(RefreshTasks event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: TaskStatusList.loading));
    try {
      final refreshedTasks = await CacheService().getAllTasks();
      emit(state.copyWith(
        status: TaskStatusList.success,
        todos: refreshedTasks,
        allTodos: refreshedTasks,
      ));
    } catch (error) {
      print('Error refreshing tasks: $error');
      emit(state.copyWith(status: TaskStatusList.failure));
    }
  }
}
