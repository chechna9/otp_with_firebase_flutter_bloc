import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/login_bloc/login_bloc.dart';
import 'package:mob_auth_fire_base/presentation/widgets/inputField.dart';

class VerifyingCode extends StatelessWidget {
  VerifyingCode({super.key});
  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginCompleted) {
                context
                    .read<AuthenticationBloc>()
                    .add(LoggedIn(token: state.userCred.toString()));
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if ((state is OtpSentState)) {
                // state as OtpSentState;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Code sent in sms",
                      style: TextStyle(fontSize: 30),
                    ),
                    const TimeLeft(),
                    CustomInputField(
                      controller: codeController,
                      labelText: 'code',
                      validator: (e) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Resend code"),
                        ),
                        TextButton(
                          onPressed: () {
                            // !todo: some verification to code entred by the user
                            context.read<LoginBloc>().add(OtpVerification(
                                state.verificationId, codeController.text));
                          },
                          child: const Text("Send Verification number"),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Text("am in this state ${state.toString()}"));
              }
            },
          ),
        ),
      ),
    );
  }
}

class TimeLeft extends StatefulWidget {
  const TimeLeft({
    super.key,
  });

  @override
  State<TimeLeft> createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: const Duration(seconds: 120),
        tween: Tween(begin: const Duration(seconds: 120), end: Duration.zero),
        builder: (BuildContext context, Duration value, Widget? child) {
          return Text(
            "Time left: ${value.inSeconds} s",
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        });
  }
}
