
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key, required this.auth}) : super(key: key);

  final authBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(auth: auth,),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

}
