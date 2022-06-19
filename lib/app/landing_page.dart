import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_app/app/Home/Home_page.dart';
import 'package:time_tracker_flutter_app/app/sing_in/sign_in_page.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';
import 'package:time_tracker_flutter_app/services/database.dart';

import 'Home/Homepage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);

  final authBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            }
            return Provider<FirestoreDatabase>(
              create: (_) => FirestoreDatabase(uid: user.uid),
                child: HomePage(
                auth: auth,
              ),
              // child: jobspage(
              //   auth: auth,
              // ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
