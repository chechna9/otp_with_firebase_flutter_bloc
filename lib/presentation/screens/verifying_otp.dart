import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/presentation/widgets/inputField.dart';

class VerifyingCode extends StatelessWidget {
  VerifyingCode({super.key});
  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
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
          )
        ],
      )),
    );
  }
}
