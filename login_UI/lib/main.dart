import 'package:flutter/material.dart';
// import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Blockchain",
      theme: ThemeData(
          // primarySwatch: Colors.red,
          ),
      home: const Homepage(),
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blockchain')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: "Email",
                border: UnderlineInputBorder(borderSide: BorderSide()),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: "Password",
                border: UnderlineInputBorder(borderSide: BorderSide()),
                labelText: 'Password',
              ),
            ),
            TextButton(onPressed: () async {}, child: const Text('Login'))
          ],
        ),
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
