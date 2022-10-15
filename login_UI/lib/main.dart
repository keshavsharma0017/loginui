import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Blockchain",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    ),
  );
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      appBar: AppBar(title: const Text('Blockchain')),
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
                await Firebase.initializeApp(options: defaultFirebase);

                final UserCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                print(UserCredential);
              },
              child: const Text('Login'))
        ],
      ),
    );
  }
}






// const Text(
//   'Hey there this is just na random command ...hehe dont laugh its not funny',
// textAlign: TextAlign.center,       // alighnment
//  textDirection: TextDirection.ltr, //  left se start ya right se
//  overflow: TextOverflow.ellipsis,  // shows the text and more..... like this
//  textScaleFactor: 5,               //text size
//  softWrap: false,                  //wrappable or not
//  maxLines: 2,                      //showes no of max line on app
//  semanticsLabel: 'Hash Sign',      //explains the texts whenhovers on web
