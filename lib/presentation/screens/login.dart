import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mob_auth_fire_base/buisiness_logic/blocs/login_bloc/login_bloc.dart';
import 'package:mob_auth_fire_base/constants/constants.dart';
import 'package:mob_auth_fire_base/presentation/screens/home.dart';
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

final _formKey = GlobalKey<FormState>();

final TextEditingController phoneCntrl = TextEditingController();

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

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
                decoration: const BoxDecoration(boxShadow: [myBoxShadow]),
                child: TextFormField(
                  controller: phoneCntrl,
                  decoration: InputDecoration(
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
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  // if (state is Unauthenticated) {
                  //   return SignUpButton(
                  //     onPressed: () {},
                  //   );
                  // } else if (state is Authenticated) {
                  //   return const HomeScreen();
                  // }
                  return Text("unhandled state ${state}");
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
