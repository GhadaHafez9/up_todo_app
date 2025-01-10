part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SignUpImageChanged extends SignUpEvent {
  final String img;

  const SignUpImageChanged(this.img);

  @override
  List<Object?> get props => [img];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

class SaveUserData extends SignUpEvent {
  final String name;
  final String? img;

  const SaveUserData(this.name, this.img);
}

class LoadUserData extends SignUpEvent {}

class ClearUserData extends SignUpEvent {}
