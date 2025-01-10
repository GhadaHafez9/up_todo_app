import 'package:hive_flutter/hive_flutter.dart';
import 'package:up_todo/Feature/Auth/data/models/user.dart';
import 'package:up_todo/Feature/Category/data/models/category_model.dart';
import 'package:up_todo/Feature/main/data/models/task_model/task_model.dart';

class CacheService {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>('tasksBox');
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>('userBox');

    Hive.registerAdapter(CategoryModelAdapter());
  }

  Future<Box> _openTaskBox() async {
    return await Hive.openBox('taskBox');
  }

  Future<void> addTask(String id, TaskModel task) async {
    final box = await _openTaskBox();
    await box.put(task.id, task);
  }

  Future getTaskById(String id) async {
    final box = await _openTaskBox();
    return box.get(id);
  }

  Future<void> updateTask(String id, TaskModel updatedTask) async {
    final box = await _openTaskBox();
    await box.put(id, updatedTask);
  }

  Future<List<TaskModel>> getAllTasks() async {
    final box = await _openTaskBox();
    return box.values.map((e) => e as TaskModel).toList();
  }

  Future<void> deleteTaskById(String id) async {
    final box = await _openTaskBox();
    await box.delete(id);
  }

  Future<void> deleteAllTasks() async {
    final box = await _openTaskBox();
    await box.clear();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final box = await Hive.openBox<CategoryModel>('categories');
    return box.values.toList();
  }

  Future<void> saveUser(String name, String img) async {
    final box = await Hive.openBox<User>('userBox');
    final user = User(name: name, img: img);
    await box.put('currentUser', user);
  }

  Future<User?> getUser() async {
    final box = await Hive.openBox<User>('userBox');
    return box.get('currentUser');
  }

  Future<void> deleteUser() async {
    final box = await Hive.openBox<User>('userBox');
    await box.delete('currentUser');
  }


}
