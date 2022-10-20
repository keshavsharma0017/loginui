// ignore: avoid_web_libraries_in_flutter,
// import 'dart:html';

// import 'dart:html';

// ignore_for_file: unused_import

// import 'dart:html';
// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/firebase_options.dart';
import 'package:login_ui/views/login_view.dart';
import 'package:login_ui/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blockchain",
      home: const HomePage(),
      routes: {
        '/login/': ((context) => const LoginView()),
        '/register/': ((context) => const RegisterView()),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const LoginView();
          default:
            return const Text('loading');
        }
      },
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAIL VERIFY"),
      ),
      body: Column(children: [
        const Text(
          "Please Verify Your Email",
          textScaleFactor: 1.5,
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text(
            "Send Email",
          ),
        ),
      ]),
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





// errorr resolved

// FutureBuilder(
//         initialData: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Center(
//               child: CircularProgressIndicator(),
//             )
//           ],
//         ),
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               final user = FirebaseAuth.instance.currentUser;
//               // print(user);
//               if (user?.emailVerified ?? false) {
//                 if (kDebugMode) {
//                   // print("hello");
//                 }
//               } else {
//                 WidgetsBinding.instance.addPostFrameCallback(
//                   (_) {
//                     // Navigator.of(context)
//                     //     .pushAndRemoveUntil( '/login/', (route) => false);

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             const VerifyEmailView(), //error in this part of the code
//                       ),
//                     );
//                   },
//                 );
//               }
//               return const LoginView();
//             default:
//               return const Text('loading');
//           }
//         },
//       ),