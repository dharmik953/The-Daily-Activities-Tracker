import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_app/commen_widget/form_submit_button.dart';
import 'package:time_tracker_flutter_app/commen_widget/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

enum EmailSignInFormType { signin, register }

class EmailSignInFormStateful extends StatefulWidget {
  const EmailSignInFormStateful({Key? key}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInFormStateful> {
  EmailSignInFormType _formType = EmailSignInFormType.signin;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final TextEditingController _usernameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passWordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  // String get _username => _usernameController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passWordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      final auth = Provider.of<authBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signin) {
        await auth.signInWithEmailAndPassWord(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signin
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _BulidChildrean() {
    final primaryText = _formType == EmailSignInFormType.signin
        ? 'Sign in'
        : 'Create an account';
    final seconderyText = _formType == EmailSignInFormType.signin
        ? 'Need An account? register'
        : 'Have an account? Sign in';

    return [
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'abc@test.com',
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        focusNode: _passWordFocusNode,
        decoration: InputDecoration(
          labelText: 'password',
        ),
        textInputAction: TextInputAction.done,
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      TextField(
        // controller: _username,
        focusNode: _passWordFocusNode,
        decoration: InputDecoration(
          labelText: 'username',
        ),
        textInputAction: TextInputAction.done,
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submit,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(seconderyText),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _BulidChildrean(),
      ),
    );
  }
}
