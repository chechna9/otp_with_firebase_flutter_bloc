import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/login_bloc/login_bloc.dart';
import 'package:mob_auth_fire_base/constants/constants.dart';
import 'package:mob_auth_fire_base/presentation/screens/home.dart';
import 'package:mob_auth_fire_base/presentation/screens/verifying_otp.dart';
import 'package:mob_auth_fire_base/presentation/widgets/inputField.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: myWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              FlutterLogo(
                size: 100,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: RegisterForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneCntrl = TextEditingController();
  late bool hideShadow;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideShadow = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontSize: 40,
            color: myRed,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! we work here
              Container(
                decoration:
                    BoxDecoration(boxShadow: hideShadow ? [] : [myBoxShadow]),
                child: TextFormField(
                  controller: phoneCntrl,
                  decoration: InputDecoration(
                    prefix: const Text("+213"),
                    suffixIcon: Icon(
                      Icons.phone,
                      color: myDark,
                    ),
                    filled: true,
                    alignLabelWithHint: true,
                    fillColor: myGrey,
                    focusedBorder:
                        CustomBurders.myOutlinedBorder(color: myDark),
                    enabledBorder: CustomBurders.myOutlinedBorder(
                        color: Colors.transparent),
                    errorBorder: CustomBurders.myOutlinedBorder(color: myRed),
                    focusedErrorBorder:
                        CustomBurders.myOutlinedBorder(color: myRed),
                    labelText: 'Phone',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: myDark.withOpacity(0.7),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.length == 9
                      ? null
                      : 'incorrect number, 9 digits needed',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is OtpSentState) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => VerifyingCode()),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginInitial) {
                    return SignUpButton(
                      onPressed: () {
                        setState(() {
                          hideShadow = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            hideShadow = false;
                          });
                          context
                              .read<LoginBloc>()
                              .add(SendOtpEvent(phoneCntrl.text));
                        }

                        try {
                          context
                              .read<LoginBloc>()
                              .add(SendOtpEvent("+213${phoneCntrl.text}"));
                        } catch (e) {
                          print(e);
                        }
                      },
                    );
                  } else if (state is LoginLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoginError) {
                    return Text("Error : ${state.errorMsg}");
                  }
                  return Text("unhandled state $state");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        backgroundColor: myDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 25,
              color: myWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
