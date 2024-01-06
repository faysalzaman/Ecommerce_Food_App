// ignore_for_file: file_names

abstract class SendOtpEvent {}

class SendOtpEventInit extends SendOtpEvent {
  String email;

  SendOtpEventInit({required this.email});
}

class VarifyOtpEvent extends SendOtpEvent {
  String email;
  String otp;

  VarifyOtpEvent({required this.email, required this.otp});
}

abstract class SendOtpState {}

class SendOtpInitialState extends SendOtpState {}

class SendOtpLoadingState extends SendOtpState {}

class SendOtpSuccessState extends SendOtpState {
  String otp;

  SendOtpSuccessState({required this.otp});
}

class SendOtpErrorState extends SendOtpState {
  String error;

  SendOtpErrorState({required this.error});
}

class VarifyOtpInitialState extends SendOtpState {}

class VarifyOtpLoadingState extends SendOtpState {}

class VarifyOtpErrorState extends SendOtpState {
  String error;

  VarifyOtpErrorState({required this.error});
}

class VarifyOtpSuccessState extends SendOtpState {}
