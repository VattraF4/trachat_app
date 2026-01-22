//package
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Service
import '../services/database_service.dart';
import '../services/navigation_service.dart';

class AuthenticatorProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  late final NavigationService _navigationService;

  AuthenticatorProvider() {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();
    _navigationService = GetIt.instance.get<NavigationService>();
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // _navigationService.navigateToRoute('/home');
      // print(_auth.currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
