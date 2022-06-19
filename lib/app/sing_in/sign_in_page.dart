import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_app/app/sing_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_app/app/sing_in/sign_in_button.dart';
import 'package:time_tracker_flutter_app/app/sing_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);

  final authBase auth;

  Future<void> _SignInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _SignInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      // fullscreenDialog: true,  //only for IOS.
      builder: (context) => EmailSignInPage(
        auth: auth,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Task App')
          ],
        ),
        elevation: 2.0,
      ),
      body: _BuildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _BuildContent(BuildContext context) {
    return Padding(
      // color: Colors.yellow,
      padding: EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            // google
            SizedBox(height: 48.0),
            social_sign_in_button(
              assestname: 'images/google-logo.png',
              text: 'Sign in with Google',
              textcolor: Colors.black87,
              onPressed: _SignInWithGoogle,
              color: Colors.white,
            ),
            //Facebook
            SizedBox(height: 8.0),
            social_sign_in_button(
              assestname: 'images/facebook-logo.png',
              text : 'Sign in with Facebook',
                    textcolor: Colors.white,
                    onPressed: () {},
                    color: Color(0xFF334D92),),
            //email
            SizedBox(height:8.0),
            Sign_in_button(
              text: 'Sign in with email',
              textcolor: Colors.white,
              onPressed: () => _signInWithEmail(context),
              color: Colors.redAccent,
            ),
            SizedBox(height: 8.0),
            Text(
              'or',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Sign_in_button(
              text: 'Go anonymous',
              textcolor: Colors.black,
              onPressed: _SignInAnonymously,
              color: Colors.lime,
            ),
          ]),
    );
  }
}
