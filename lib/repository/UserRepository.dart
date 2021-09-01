import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_banking/ui/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final _databaseReference = FirebaseFirestore.instance;

  void loginUser(email, password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavigationPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(content: Text('Korisnik nije pronadjen'));
        Scaffold.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(content: Text('Pogrešna šifra'));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> createStudent(email, password, username, context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      addUserToDB(email, username, context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {}
    } catch (e) {
      print(e);
    }
  }

  void addUserToDB(email, username, context) async {
    await _databaseReference
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'uid': FirebaseAuth.instance.currentUser.uid,
      'username': username,
      'email': email
    });
    await _databaseReference.collection('money_status').doc(FirebaseAuth.instance.currentUser.uid).set({
      'amount' : 10000
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NavigationPage()));
  }
}
