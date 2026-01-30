//package
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Service
import '../services/database_service.dart';
import '../services/navigation_service.dart';

//Models
import '../models/users.dart';

class AuthenticatorProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  late final NavigationService _navigationService;

  late ChatUser users;

  AuthenticatorProvider() {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();
    _navigationService = GetIt.instance.get<NavigationService>();
    // _auth.signOut();

    _auth.authStateChanges().listen((user) async {
      // ← ADD async HERE
      if (user != null) {
        await _databaseService.updateUserLastSeenTime(user.uid); // ← ADD await
        final snapshot = await _databaseService.getUser(
          user.uid,
        ); // ← ADD await

        if (snapshot.exists && snapshot.data() != null) {
          Map<String, dynamic> userData =
              snapshot.data()! as Map<String, dynamic>;
          users = ChatUser.fromJson({
            "uid": user.uid,
            "name": userData['name'],
            "email": userData['email'],
            "imageUrl": userData['imageUrl'],
            'lastActive': userData['lastActive'],
          });
          // print(users.toMap());
          _navigationService.removeAnyNavigateToRoute('/home');
        }
      } else {
        // print("${DateTime.now()}: Not Authenticated");
         
        _navigationService.removeAnyNavigateToRoute('/login')
      }
      notifyListeners(); // Now this waits for everything
    });
  }

  Future<void> login(String email, String password) async {
    try {
      // UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // if (userCredential.user != null) {
      //   await _databaseService.updateUserLastSeenTime(userCredential.user!.uid);
      // _navigationService.navigateToRoute('/home');
      // print(_auth.currentUser);
      // }
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
