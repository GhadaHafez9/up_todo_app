import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/Feature/Category/presentation/widgets/category_fun.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';
import 'package:up_todo/core/cache_service/cache_service.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';
import 'package:uuid/uuid.dart';

import '../../../../Category/data/models/category_model.dart';
import 'add_task_event.dart';
import 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc()
      : super(AddTaskState(startDate: DateTime.now(), isChecked: false)) {
    on<TaskTitleChanged>(onTitleChanged);
    on<TaskDescriptionChanged>(onDescriptionChanged);
    on<TaskStartDateChanged>(onStartDateChanged);
    on<TaskEndDateChanged>(onEndDateChanged);
    on<TaskCategoryChanged>(onCategoryChanged);
    on<LoadCategories>(onLoadCategories);
    on<TaskPriorityChanged>(onPriorityChanged);
    on<SubmitTask>(onSubmitTask);
  }

  void onTitleChanged(TaskTitleChanged event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(
      title: event.title,
      isChecked: _validateForm(event.title, state.description, state.category),
    ));
  }

  void onDescriptionChanged(
      TaskDescriptionChanged event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(
      description: event.description,
      isChecked: _validateForm(state.title, event.description, state.category),
    ));
  }

  void onStartDateChanged(
      TaskStartDateChanged event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void onEndDateChanged(TaskEndDateChanged event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(endDate: event.endDate));
  }

  void onCategoryChanged(
      TaskCategoryChanged event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        category: event.category,
      ),
    );
  }

  void onLoadCategories(
      LoadCategories event, Emitter<AddTaskState> emit) async {
    final category = await CacheService().getAllCategories();
    if (category.isEmpty) {
      print('using default categories');
      category.addAll(generateCategories());
    } else {
      print('Categories: ${category.length}');
    }
    emit(state.copyWith(categoryList: category));
  }

  void onPriorityChanged(
      TaskPriorityChanged event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(priority: event.priority));
  }

  Future<void> onSubmitTask(
      SubmitTask event, Emitter<AddTaskState> emit) async {
    final id = await Uuid().v4();

    final task = TaskModel(
      id: id,
      title: sl<AddedTaskData>().titleController.text.trim(),
      description: sl<AddedTaskData>().descriptionController.text.trim(),
      startDate: state.startDate,
      category: state.category,
      priority: state.priority,
      isChecked: state.isChecked,
    );

    final tasks = await CacheService().getAllTasks();

    await CacheService().addTask(task.id, task);

    final tasks2 = await CacheService().getAllTasks();

    emit(state.copyWith(status: TaskStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: TaskStatus.success , tasks: tasks2));
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(status: TaskStatus.failure));
    }
  }

  bool _validateForm(
      String title, String description, CategoryModel? category) {
    return title.isNotEmpty && description.isNotEmpty && category != null;
  }
}
