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
      await _userRepository.sendOtp(
        event.phoneNumber,
        const Duration(seconds: 120),
        (error) {
          emit(
            LoginError(error.message ?? "Uknown Error"),
          );
        },
        (phoneAuthCredential) {},
        (verificationId, forceResendingToken) {
          emit(OtpSentState(verificationId, forceResendingToken));
        },
        (verificationId) {},
      );
      emit.isDone;
    });
    on<OtpVerification>((event, emit) async {
      // verify the verification code entered by the user using Firebase Auth API
      try {
        emit(LoginLoading());
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(LoginCompleted());
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
