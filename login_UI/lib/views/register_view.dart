import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import 'package:login_ui/utilities/show_error_dialogs.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        appBar: AppBar(
            title: const Center(
          child: Text('Register Here'),
        )),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!(RegExp(r'[?=*(0-9)]').hasMatch(value))) {
                    return "it is an error";
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passowrd,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: "Password",
                  filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _passowrd.text;
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // devtools.log(userCredential.toString());
                      if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                          context, verifyEmailRoute, (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "weak-password") {
                        // devtools.log("Weak Password");
                        await showErrorDialog(
                          context,
                          'Weak Password',
                        );
                      } else if (e.code == "email-already-in-use") {
                        // devtools.log("Email Already In Use");
                        await showErrorDialog(
                          context,
                          'Email Already In Use',
                        );
                      } else if (e.code == "invalid-email") {
                        // devtools.log("Invalid Email");
                        await showErrorDialog(
                          context,
                          'Invaild Email',
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
                  child: const Text('Register')),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                child: const Text("Already a user? Login Here"),
              ),
            ],
          ),
        ));
  }
}
