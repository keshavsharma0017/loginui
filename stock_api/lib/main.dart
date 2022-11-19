import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import 'package:login_ui/firebase_options.dart';
import 'package:login_ui/views/forget_password.dart';
import 'package:login_ui/views/home.dart';
import 'package:login_ui/views/login_view.dart';
import 'package:login_ui/views/register_view.dart';
import 'package:login_ui/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "stockapi",
      home: const HomePage(),
      routes: {
        loginRoute: ((context) => const LoginView()),
        registerRoute: ((context) => const RegisterView()),
        verifyEmailRoute: ((context) => const VerifyEmailView()),
        homeRoute: ((context) => const Home()),
        forgotPasswordRoute: ((context) => const ForgetPassword()),
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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                // print('Email is verified');
                return const Home();
                // return const Home();
              } else {
                return const VerifyEmailView(); //needs to send login page and pop msg of verifying it later
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
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