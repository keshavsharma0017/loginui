import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Login',
        )),
        body: (Center(
          child: Container(
            height: 250,
            width: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: (const BorderRadius.all(Radius.circular(25))),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 105, 105, 105),
                  blurRadius: 3.0,
                  spreadRadius: 5.0,
                )
              ],
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            child: const Text(
              'WELCOME',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        )),
        // Center(
        //   child: (
        //     Text:
        //     ),)
        // ,
      )));
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
