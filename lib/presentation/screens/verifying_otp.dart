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
      body: Form(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginCompleted) {
              context
                  .read<AuthenticationBloc>()
                  .add(LoggedIn(token: state.userCred.toString()));
            }
          },
          builder: (context, state) {
            if (state is OtpSentState) {
              // state as OtpSentState;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Code sent in sms",
                    style: TextStyle(fontSize: 30),
                  ),
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
                          print("state verId ${state.verificationId}");
                          context.read<LoginBloc>().add(
                              OtpVerification(state.verificationId, "123456"));
                        },
                        child:
                            const Text("Send Verification Verification number"),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Text("am in this state ${state.toString()}");
            }
          },
        ),
      ),
    );
  }
}
