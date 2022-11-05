// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import 'package:login_ui/utilities/pop_up.dart';
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
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Image.asset('assets/images/logp4.webp'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Forgot \nPassword?",
                    style: TextStyle(
                      fontSize: 25,
                      // color: Colors.blue,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      decorationThickness: 4,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                  hintText: "",
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value))) {
                    return "Incorrect email Format";
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailv.text;
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    if (!mounted) {}
                    popUp(context, "Password reset mail has been sent");
                  } on FirebaseAuthException catch (e) {
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
                  } catch (e) {
                    if (!mounted) {}
                    await showErrorDialog(
                      context,
                      e.toString(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Submit'),
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
