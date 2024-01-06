// ignore_for_file: file_names

abstract class AuthEvent {}

class SignupButtonPressedEvent extends AuthEvent {
  String email;
  String password;

  SignupButtonPressedEvent({
    required this.email,
    required this.password,
  });
}

abstract class AuthState {}

class SignupInitial extends AuthState {}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  String error;

  SignupFailure({required this.error});
}

class LoginButtonPressedEvent extends AuthEvent {
  String email;
  String password;

  LoginButtonPressedEvent({
    required this.email,
    required this.password,
  });
}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  String isNewUser;

  LoginSuccess({required this.isNewUser});
}

class LoginFailure extends AuthState {
  String error;

  LoginFailure({required this.error});
}

class RefreshSuccessEvent extends AuthEvent {
  bool token;

  RefreshSuccessEvent({required this.token});
}

class RefreshSuccessState extends AuthState {
  bool token;

  RefreshSuccessState({required this.token});
}

class RefreshFailureState extends AuthState {
  String msg;

  RefreshFailureState({required this.msg});
}

class RefreshLoadingState extends AuthState {}
