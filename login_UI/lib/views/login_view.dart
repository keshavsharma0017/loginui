import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

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
      // appBar: AppBar(title: const Text('Login')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
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
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          // ignore: avoid_print
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "user-not-found") {
                            print("User details is Invalid");
                            // print(e);
                            // print(e.runtimeType);
                          } else if (e.code == "wrong-password") {
                            print("Invaild Password");
                          }
                        }
                      },
                      child: const Text('Login'))
                ],
              );
            default:
              return const Text('loading');
          }
        },
      ),
    );
  }
}
