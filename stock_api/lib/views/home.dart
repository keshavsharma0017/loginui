import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

enum MenuAction { logout }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final email = FirebaseAuth.instance.currentUser?.email;
TextEditingController textController = TextEditingController();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Center(child: Text("Home")),
        actions: [
          AnimSearchBar(
            width: 300,
            color: Colors.black,
            helpText: "Search...",
            style: const TextStyle(
              color: Colors.white,
            ),
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
                // FocusScope.of(context).unfocus();
              });
            },
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  // devtools.log(shouldLogout.toString());
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    if (!mounted) return;
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      loginRoute,
                      (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: MenuAction.logout, child: Text('Logout')),
              ];
            },
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 15.0),
              // padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              // duration: const Duration(milliseconds: 2500),
              // curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Text(
                "Welcome,\n\n $email",
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
            ListTile(
              title: const Text(
                'Info',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Setting',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                final shouldLogout = showLogOutDialog(context);
                if (await shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  await Navigator.pushNamedAndRemoveUntil(
                    context,
                    loginRoute,
                    (_) => false,
                  );
                }
                // FirebaseAuth.instance.signOut();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, loginRoute, (route) => false);
              },
            ),
            ListTile(
              title: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are You sure You Want To Logout"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}





// devtools.log(value.toString());
              // print(value);                         //dont use this instead use log