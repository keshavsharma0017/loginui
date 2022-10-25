// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utilities/show_error_dialogs.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController _emailv;

  @override
  void initState() {
    _emailv = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _emailv,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              // labelText: 'Email To be Verivied',
              contentPadding: EdgeInsets.only(left: 10),
              hintText: "Email To be Verivied",
              border: UnderlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _emailv.text;
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: email)
                  .catchError((e) {
                if (e.code == "invalid-email") {
                  showErrorDialog(
                    context,
                    'Email format is not Correct',
                  );
                  // print(e);
                  // print(e.runtimeType);
                }
              });
            },
            child: const Text('Send Email Verification'),
          )
        ],
      ),
    );
  }
}
