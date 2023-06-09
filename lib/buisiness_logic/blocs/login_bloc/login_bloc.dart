import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mob_auth_fire_base/repositeries/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserRepository _userRepository;

  LoginBloc(UserRepository userRepository) : super(LoginInitial()) {
    _userRepository = userRepository;

    on<SendOtpEvent>((event, emit) async {
      emit(LoginLoading());
      // calling the firebase api
      debugPrint("numero:${event.phoneNumber}.");
      await _userRepository.sendOtp(
        event.phoneNumber,
        const Duration(seconds: 120),
        (error) {
          // can't emit directly here
          // LoginError(error.message ?? "");
          emittingLoginError(error.message);
        },
        (phoneAuthCredential) {},
        (verificationId, forceResendingToken) {
          // can't emit directly here
          // emit(OtpSentState(verificationId, forceResendingToken));
          emittingOTPSentState(verificationId, forceResendingToken);
        },
        (verificationId) {},
      );
    });

    on<OtpVerification>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          UserCredential userCred = await userRepository.verifyAndLogin(
              event.verificationId, event.smsCode);

          emit(LoginCompleted(userCred: userCred));
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      },
    );
  }
  void emittingOTPSentState(verificationId, forceResendingToken) {
    emit(OtpSentState(verificationId, forceResendingToken));
  }

  void emittingLoginError(error) {
    emit(LoginError(error));
  }
}
