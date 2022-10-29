import 'dart:developer' as devtools show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import 'package:login_ui/utilities/pop_up.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    user?.sendEmailVerification();
    return Scaffold(
        appBar: AppBar(
          title: const Text("MAIL VERIFY"),
        ),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Verification Mail has been Sent",
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await user?.sendEmailVerification();
              devtools.log(user.toString());
              if (!mounted) return;
              popUp(context, 'Verification mail has been sent');
            },
            child: const Text(
              "Send Email",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(
                context,
                loginRoute,
                (route) => false,
              );
            },
            child: const Text(
              "If Verified , Click Here",
            ),
          ),
        ]));
  }
}
