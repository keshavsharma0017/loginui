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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailv,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.only(
                  left: 10,
                ),
                filled: true,
                hintText: "Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
                  } else if (e.code == "unknown") {
                    showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                  }
                });
              },
              child: const Text('Send Email Verification'),
            )
          ],
        ),
      ),
    );
  }
}
