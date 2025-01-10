part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState extends Equatable {
  final String name;
  final String img;
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState({
    this.name = '',
    this.img = '',
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? name,
    String? img,
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      img: img ?? this.img,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [name, img, status, errorMessage];
}
