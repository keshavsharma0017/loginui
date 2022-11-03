import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/constant/route.dart';

enum MenuAction { logout }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final email = FirebaseAuth.instance.currentUser?.email;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
        actions: [
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 15.0),
              // padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              // duration: const Duration(milliseconds: 2500),
              // curve: Curves.fastOutSlowIn,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Welcome,\n\n456 $email",
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
            ),
            ListTile(
              title: const Text('Info'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Logout'),
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
              title: const Text('Close'),
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