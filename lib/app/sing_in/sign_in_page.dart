import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_app/app/sing_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_app/app/sing_in/sign_in_button.dart';
import 'package:time_tracker_flutter_app/app/sing_in/sign_in_manager.dart';
import 'package:time_tracker_flutter_app/app/sing_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

import '../../commen_widget/show_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;

  SignInPage({
    final Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);

  static const Key emailPasswordKey = Key('email-password');

  static Widget create(BuildContext context) {
    final auth = Provider.of<authBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) =>
                SignInPage(manager: manager, isLoading: isLoading.value),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _SignInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<authBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _SignInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<authBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      // await widget.manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    final auth = Provider.of<authBase>(context, listen: false);
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
          children: [Text('Task App')],
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
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ), // google
            SizedBox(height: 48.0),
            social_sign_in_button(
              assestname: 'images/google-logo.png',
              text: 'Sign in with Google',
              textcolor: Colors.black87,
              onPressed: () => _SignInWithGoogle(context),
              color: Colors.white,
            ),
            //Facebook
            SizedBox(height: 8.0),
            social_sign_in_button(
              assestname: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textcolor: Colors.white,
              onPressed: () {},
              color: Color(0xFF334D92),
            ),
            //email
            SizedBox(height: 8.0),
            Sign_in_button(
              text: 'Sign in with email',
              textcolor: Colors.white,
              onPressed: () => _signInWithEmail(context),
              // onPressed: isLoading ? null : () => _signInWithEmail(context),
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
              onPressed: () => _SignInAnonymously(context),
              color: Colors.lime,
            ),
          ]),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
