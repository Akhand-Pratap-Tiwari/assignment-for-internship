import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'check_vat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Finance"),
        centerTitle: true,
      ),
      drawer: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.cyan, Colors.teal],
                      stops: [0, 1],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  accountName: Text(user.displayName!),
                  accountEmail: Text(user.email!),
                  currentAccountPicture: CircleAvatar(
                    foregroundImage: NetworkImage(user.photoURL ??
                        "https://img.freepik.com/premium-vector/cute-astronaut-cat-floating-space_482416-161.jpg?w=2000"),
                  ),
                ),
                ListTile(leading: Icon(Icons.home), title: Text("Home")),
                ListTile(leading: Icon(Icons.share), title: Text("Share")),
                ListTile(leading: Icon(Icons.help), title: Text("Help")),
                SignOutButton(),
              ],
            ),
          ),
        ),
      ),
      body: CheckVAT(),
    );
  }
}
