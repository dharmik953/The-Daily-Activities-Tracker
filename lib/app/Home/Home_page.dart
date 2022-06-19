import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

class jobspage extends StatelessWidget {
  const jobspage({Key? key, required this.auth}) : super(key: key);

  final authBase auth;

  static const String profile = 'Profile';
  static const String govet_schemes = 'Govt Schemes';
  static const String BJP_feed = 'BJP Gujarat Feed';
  static const String third_party_feed = '3rd party pages feed';
  static const String log_out = 'Log out';

  void _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          FlatButton(
              onPressed: () => _signOut(),
              child: Text(
                'log out',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
        centerTitle: true,
      ),
      // drawer: navDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            // "your id is:" + auth.user_id),
            "your id is:" + DateTime.now().millisecondsSinceEpoch.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
