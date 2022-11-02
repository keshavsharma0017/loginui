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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Image.asset('assets/images/logp3.webp'),
              ),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  // filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.account_circle_outlined,
                    ),
                  ),
                  hintText: "username",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Username cannot be empty";
                  } else {
                    return null;
                  }
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  // filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.alternate_email_sharp,
                    ),
                  ),
                  hintText: "Email",
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
                    return "incorrect email";
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
                  // filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.lock_outline_rounded,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: 'Password',
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "password cannot be empty";
                  } else if (!(RegExp(
                          r"^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&-+=()]).{8,20}$")
                      .hasMatch(value))) {
                    return "Password must contain 1 upper case,1 lower case \nand a special char ";
                  } else {
                    return null;
                  }
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _passowrd.text;
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Register'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Already a user? Login Here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









  // ^ represents starting character of the string.
// (?=.*[0-9]) represents a digit must occur at least once.
// (?=.*[a-z]) represents a lower case alphabet must occur at least once.
// (?=.*[A-Z]) represents an upper case alphabet that must occur at least once.
// (?=.*[@#$%^&-+=()] represents a special character that must occur at least once.
// (?=\\S+$) white spaces don’t allowed in the entire string.
// .{8, 20} represents at least 8 characters and at most 20 characters.
// $ represents the end of the string.