import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:up_todo/Feature/main/presentation/controllers/added_task_data.dart';
import 'package:up_todo/core/cache_service/cache_service.dart';
import 'package:up_todo/core/components/resources/service_locator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpImageChanged>(_onImageChanged);
    on<SignUpSubmitted>(_onSubmitted);
    on<LoadUserData>(_onLoadUserData);
    on<SaveUserData>(_onSaveUserData);
    on<ClearUserData>(_onClearUserData);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(name: sl<AddedTaskData>().nameController.text.trim()));
  }

  void _onImageChanged(SignUpImageChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(img: event.img));
  }

  Future<void> _onSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (state.name.isEmpty || state.img == null) {
      emit(state.copyWith(errorMessage: 'All fields are required.'));
      return;
    }
  }

  void _onSaveUserData(SaveUserData event, Emitter<SignUpState> emit) async {
    await CacheService().saveUser(
      event.name,
      event.img!,
    );
    emit(state.copyWith(errorMessage: 'User saved successfully.'));
  }

  void _onLoadUserData(LoadUserData event, Emitter<SignUpState> emit) async {
    final user = await CacheService().getUser();
    if (user != null) {
      emit(state.copyWith(name: user.name, img: user.img));
    } else {
      emit(state.copyWith(errorMessage: 'User not found'));
    }
  }

  void _onClearUserData(ClearUserData event, Emitter<SignUpState> emit) async {
    await CacheService().deleteUser();
    emit(state.copyWith(errorMessage: 'User cleared successfully.'));
  }
}
