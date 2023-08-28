import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_dots/models/current_user.dart';
// ignore: unused_import
import 'package:campus_dots/services/event.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create users obj based on firebase user
  CurrentUser? _customModelForUser(User? user) {
    //return user != null ? CurrentUser(uid: user.uid) : null;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return CurrentUser(uid: user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<CurrentUser?> get currentUser {
    return _auth.authStateChanges().map(_customModelForUser);
    //.map((User user) => _customModelForUser(user));
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //sign in email and pwd
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _customModelForUser(user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //register with email and pwd
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // //create a new doc for the user with the uid
      // await Event(uid: user!.uid).updateEventData(
      //     'Cultural',
      //     "Shreya ma'am",
      //     '10:00 am',
      //     'CS students',
      //     'make digital poster on given topic',
      //     'Csfiesta dance',
      //     'CPA building');

      return _customModelForUser(user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
