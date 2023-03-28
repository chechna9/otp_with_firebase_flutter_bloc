import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/repositeries/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    // app started event

    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.getUser() != null;
      if (hasToken) {
        // emit(Authenticated());
        emit(Unauthenticated());
      } else {
        emit(Unauthenticated());
      }
    });
    // logged in event
    on<LoggedIn>((event, emit) {
      emit(Loading());
      emit(Authenticated());
    });
    // loged out event
    on<LoggedOut>((event, emit) {
      emit(Loading());
      emit(Unauthenticated());
    });
  }
}
