import 'package:cryptonite/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cryptonite/constant/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cryptonite",
      home: const Enter(),
      routes: {
        homeRoute: ((context) => const Home()),
      },
    );
  }
}

class Enter extends StatefulWidget {
  const Enter({super.key});

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            heightFactor: 15.0,
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(homeRoute, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text('Enter'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
