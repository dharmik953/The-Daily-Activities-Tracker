import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_app/app/Home/profilePage.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../commen_widget/form_submit_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final authBase auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController partyPosition = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController whatsAppNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController faceBookLink = TextEditingController();
  TextEditingController twitterLink = TextEditingController();
  TextEditingController instagramLink = TextEditingController();
  TextEditingController namoAppLink = TextEditingController();

  Auth auth_a = Auth();

  static const String profile = 'Profile';
  static const String govet_schemes = 'Govt Schemes';
  static const String BJP_feed = 'BJP Gujarat Feed';
  static const String third_party_feed = '3rd party pages feed';
  static const String log_out = 'Log out';

  get auth__ => widget.auth;
  var snapshot;

  @override
  Widget build(BuildContext context) {
    readDataforurl();

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        drawer: navDrawer(),
        body: Column(
          children: [
            Flexible(
              child: listOfContent(),
            ),
            Container(
              // A fixed-height child.
              color: const Color(0xFFFF9800), // Yellow
              height: 70.0,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    iconSize: 45,
                    onPressed: () {
                      _launchInBrowser(snapshot['facebook']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    iconSize: 45,
                    onPressed: () {
                      _launchInBrowser(snapshot['namoapp']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera),
                    iconSize: 45,
                    onPressed: () {
                      _launchInBrowser(snapshot['instagram']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.abc),
                    iconSize: 45,
                    onPressed: () {
                      _launchInBrowser(snapshot['twitter']);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  SingleChildScrollView listOfContent() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            // minHeight: viewportConstraints.maxHeight,
            ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: firstname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: lastname,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: partyPosition,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Party position',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: city,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'District/city',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: whatsAppNo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'WhatsApp No.',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: emailId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email ID',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: faceBookLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Facebook Link',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: twitterLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Twitter Link',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: TextFormField(
                  controller: instagramLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Instagram Link',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: namoAppLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Namo App Link',
                  ),
                ),
              ),
              // SizedBox(height: 8.0),
              FormSubmitButton(
                text: 'submit',
                onPressed: _submit,
              ),
              SizedBox(height: 8.0),

              FormSubmitButton(
                text: 'get data',
                onPressed: () => readData(),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Drawer navDrawer() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.orange,
          ),
          child: Text(
            'User Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(
            profile,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          // onTap: readData(),
          leading: Icon(Icons.paste),
          title: Text(
            govet_schemes,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            BJP_feed,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            third_party_feed,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            log_out,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => signOut(),
        ),
      ],
    ));
  }

  signOut() async {
    try {
      await auth__.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void _submit() {
    final firstName = firstname.text;
    final lastName = lastname.text;
    final partyposition = partyPosition.text;
    final city_ = city.text;
    final whatsapp = whatsAppNo.text;
    final email = emailId.text;
    final password__ = password.text;
    final facebook = faceBookLink.text;
    final twitter = twitterLink.text;
    final instagram = instagramLink.text;
    final namoapp = namoAppLink.text;

    createData(
      fname: firstName,
      lname: lastName,
      pposition: partyposition,
      city: city_,
      whatsappno: whatsapp,
      emailId: email,
      Password: password__,
      faceBook: facebook,
      twitter: twitter,
      instaGram: instagram,
      namoApp: namoapp,
    );
  }

  Future<User?> readData() async {
    snapshot = await FirebaseFirestore.instance
        .collection('userData')
        .doc(auth_a.auth?.uid)
        .get();

    _showMyDialog();
    return snapshot['first_name'];
  }

  Future<User?> readDataforurl() async {
    snapshot = await FirebaseFirestore.instance
        .collection('userData')
        .doc(auth_a.auth?.uid)
        .get();

    return snapshot['first_name'];
  }

  void _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data from firebase firestore'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'First name: ' + snapshot['first_name'],
                ),
                const SizedBox(height: 5),
                Text('Last name: ' + snapshot['last_name']),
                const SizedBox(height: 5),
                Text('Party position: ' + snapshot['party_position']),
                const SizedBox(height: 5),
                Text('City: ' + snapshot['city']),
                const SizedBox(height: 5),
                Text('Email: ' + snapshot['email']),
                // Text(snapshot['first_name']),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void createData(
      {required String fname,
      required String lname,
      required String pposition,
      required String city,
      required String whatsappno,
      required String emailId,
      required String Password,
      required String faceBook,
      required String twitter,
      required String instaGram,
      required String namoApp}) async {
    final docData =
        FirebaseFirestore.instance.collection('userData').doc(auth_a.auth?.uid);

    final json = {
      'first_name': fname,
      'last_name': lname,
      'party_position': pposition,
      'city': city,
      'whatsapp': whatsappno,
      'email': emailId,
      'password': Password,
      'facebook': faceBook,
      'twitter': twitter,
      'instagram': instaGram,
      'namoapp': namoApp,
    };

    await docData.set(json);
  }
}
