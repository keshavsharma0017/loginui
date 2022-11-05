import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          key: _formKey,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Image.asset('assets/images/logp2.webp'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Login",
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
              TextFormField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  // filled: true,
                  // contentPadding: EdgeInsets.only(
                  //   left: 10,
                  // ),
                  hintText: "",
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.alternate_email_sharp,
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
              // const SizedBox(
              //   height: 20,
              // ),
              TextFormField(
                controller: _passowrd,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: "",
                  // filled: true,
                  // contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Password',
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
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "password cannot be empty";
                  } else {
                    return null;
                  }
                }),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      forgotPasswordRoute,
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              ElevatedButton(
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
                        'Email not verified yet, an Email verification has been sent to your Email',
                      );
                      user?.sendEmailVerification();
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Not Registered Yet ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: " Click Here",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registerRoute,
                            (route) => false,
                          );
                        },
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     GoogleSignInAccount? googleUser =
              //         await GoogleSignIn().signIn();
              //     GoogleSignInAuthentication? googleAuth =
              //         await googleUser?.authentication;
              //     final credential = GoogleAuthProvider.credential(
              //       accessToken: googleAuth?.accessToken,
              //       idToken: googleAuth?.idToken,
              //     );
              //     UserCredential credentialUser = await FirebaseAuth.instance
              //         .signInWithCredential(credential);
              //     User? user = credentialUser.user;
              //   },
              //   child: const Text('Google'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}





//dont need this idk why
// final user = FirebaseAuth.instance.currentUser;
//                     if (user?.emailVerified ?? false) {
//                     }




// const Text(
              //   'Not Registered?',
              // ),
              // TextButton(
              //   onPressed: () async {
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //       registerRoute,
              //       (route) => false,
              //     );
              //   },
              //   child: const Text(
              //     "Click Here",
              //   ),
              // ),