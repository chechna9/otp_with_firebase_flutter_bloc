import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/constants/constants.dart';
import 'package:mob_auth_fire_base/presentation/widgets/inputField.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
              FlutterLogo(),
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
final TextEditingController fnameCntrl = TextEditingController();
final TextEditingController lnameCntrl = TextEditingController();
final TextEditingController phoneCntrl = TextEditingController();
final TextEditingController passwordCntrl = TextEditingController();

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sign Up',
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
              CustomInputField(
                labelText: 'First Name',
                controller: fnameCntrl,
                validator: (e) => e!.isEmpty ? 'required field' : null,
              ),
              const SizedBox(height: 15),
              CustomInputField(
                labelText: 'Last Name',
                controller: lnameCntrl,
                validator: (e) => e!.isEmpty ? 'required field' : null,
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
              CustomPasswordInput(
                labelText: 'Password',
                controller: passwordCntrl,
                validator: (e) => e!.length < 6 ? 'at least 6 character' : null,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Row(
                children: [
                  const Flexible(child: SIGoogleButton()),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: SignUpButton(
                      onPressed: () {},
                    ),
                  ),
                ],
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
            'Sign Up',
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

class SIGoogleButton extends StatelessWidget {
  const SIGoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        backgroundColor: myGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("coming soon"),
        ));
      },
      child: Row(
        children: const [
          FlutterLogo(),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              'Sign up with Google',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
