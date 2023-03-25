part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  final String phoneNumber;
  const SendOtpEvent(this.phoneNumber);
}

class OtpVerification extends LoginEvent {
  final String verificationId;
  final String smsCode;

  const OtpVerification(this.verificationId, this.smsCode);
}

class ResendOTPEvent extends LoginEvent {
  final String phoneNumber;

  const ResendOTPEvent(this.phoneNumber);
}

class CancelOTPEvent extends LoginEvent {}
