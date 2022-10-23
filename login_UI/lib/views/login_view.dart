import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import '../utilities/show_error_dialogs.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _passowrd;

  @override
  void initState() {
    _email = TextEditingController();
    _passowrd = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _passowrd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // future: Firebase.initializeApp(),
        appBar: AppBar(title: const Text('Login')),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.only(left: 10),
                hintText: "Email",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            TextFormField(
              controller: _passowrd,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: "Password",
                contentPadding: EdgeInsets.only(left: 10),
                border: UnderlineInputBorder(borderSide: BorderSide()),
                labelText: 'Password',
              ),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _passowrd.text;
                  try {
                    // final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // devtools.log(userCredential.toString());

                    final user = FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified ?? false) {
                      //users email is now verified
                      if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        homeRoute,
                        (route) => false,
                      );
                    } else {
                      //user email is not verivied
                      if (!mounted) return;
                      await showErrorDialog(
                        context,
                        'Email not varified yet',
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "user-not-found") {
                      await showErrorDialog(
                        context,
                        'User Not Found',
                      );
                      // print(e);
                      // print(e.runtimeType);
                    } else if (e.code == "wrong-password") {
                      await showErrorDialog(
                        context,
                        'Invaild Password',
                      );
                    } else {
                      await showErrorDialog(
                        context,
                        'Error: ${e.code}',
                      );
                    }
                  } catch (e) {
                    await showErrorDialog(
                      context,
                      e.toString(),
                    );
                  }
                },
                child: const Text('Login')),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("Not Registered Yet? Register Here"),
            ),
          ],
        ));
  }
}





//dont need this idk why
// final user = FirebaseAuth.instance.currentUser;
//                     if (user?.emailVerified ?? false) {
//                     }