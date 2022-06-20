import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});

  final ValueNotifier<bool> isLoading;
  final authBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    } finally {}
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User?> signInWithGoogle() async =>
      await _signIn(auth.signInAnonymously);
}
