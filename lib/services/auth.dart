import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class authBase{
  User? get currentuser;

  // String get uid => uid;

  // String get user_id => user_id;
  Stream<User?> authStateChanges();
  Future<User> signInAnonymously();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailAndPassWord(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements authBase{

  final _fireauth =  FirebaseAuth.instance;
  final auth =  FirebaseAuth.instance.currentUser;
  // final User? user_id =  FirebaseAuth.instance.currentUser?.uid as User?;


  @override
  Stream<User?>  authStateChanges() => _fireauth.authStateChanges();

  @override
  User? get currentuser =>_fireauth.currentUser;

  @override
  Future<User> signInAnonymously() async {
      final userCredentials = await _fireauth.signInAnonymously();
      return (userCredentials.user!);
  }

  @override
  Future<User?> signInWithEmailAndPassWord(String email, String password) async {
    final userCredentials = await _fireauth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
    );
    return (userCredentials.user);
  }

  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async{
    final userCredentials = await _fireauth.createUserWithEmailAndPassword(email: email, password: password);
    return (userCredentials.user);
  }

  @override
  Future<User?> signInWithGoogle() async{
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      final googleAuth = await googleUser.authentication;
      if(googleAuth.idToken != null){
        final userCredential = await _fireauth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        ));
        return userCredential.user;
      } else{
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing google i Id token',
        );
      }
    } else{
      throw FirebaseAuthException(
          code: 'ERROR_ABOetED_BY_USER',
          message: 'Sign in aborted by user'
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _fireauth.signOut();
  }

  @override
  // TODO: implement uid
  String get uid => throw UnimplementedError();
}