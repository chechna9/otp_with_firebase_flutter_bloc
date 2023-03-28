part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class OtpSentState extends LoginState {
  // when we wait for the user to enter the verification code
  final String verificationId;
  final int? resendToken;

  const OtpSentState(this.verificationId, this.resendToken);
}

class LoginCompleted extends LoginState {
  // when verification is checked
  final UserCredential userCred;
  const LoginCompleted({required this.userCred});
}

class LoginError extends LoginState {
  final String errorMsg;
  const LoginError(this.errorMsg);
}
