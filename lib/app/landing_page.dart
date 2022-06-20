import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_app/app/sing_in/sign_in_page.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';
import 'package:time_tracker_flutter_app/services/database.dart';

import 'Home/home_page.dart';

class LandingPage extends StatelessWidget {
  // const LandingPage({Key? key, required this.databaseBuilder}) : super(key: key);
  // final Database Function(String) databaseBuilder;

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<authBase>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              // child: HomePage(
              // auth: auth,
              // ),
              child: HomePage(),
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
