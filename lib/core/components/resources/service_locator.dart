import 'package:get_it/get_it.dart';
import 'package:up_todo/Feature/Auth/presentation/controllers/sign_up_bloc.dart';
import 'package:up_todo/Feature/Home/presentation/controllers/task_list_bloc.dart';
import 'package:up_todo/Feature/main/presentation/controllers/add_task/add_task_bloc.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';

final GetIt sl = GetIt.instance;

void initGetIt() {
  sl.registerFactory(() => AddTaskBloc());
  sl.registerLazySingleton(() => AddedTaskData());
  sl.registerFactory(() => SignUpBloc());
  sl.registerFactory(() => TaskListBloc());
}
