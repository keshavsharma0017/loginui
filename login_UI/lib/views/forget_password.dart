// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Image.asset('assets/images/logp4.webp'),
              ),
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
                  // filled: true,
                  hintText: "Email",
                  border: UnderlineInputBorder(
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Send Email Verification'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
