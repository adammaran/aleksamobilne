import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_banking/models/payment_model.dart';
import 'package:e_banking/ui/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentRepository {
  BuildContext context;

  PaymentRepository({this.context});

  final _databaseReference = FirebaseFirestore.instance;

  Future<List<Payment>> getPaymentList() async {
    List<Payment> paymentList = [];
    QuerySnapshot doc = await _databaseReference
        .collection('payment_history')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();
    doc.docs.forEach((element) {
      paymentList.add(Payment.create(
          amount: int.parse(element.get('amount')),
          title: element.get('title'),
          type: element.get('type'),
          id: element.get('id')));
    });
    return paymentList;
  }

  Future<List<Payment>> getPaymentListByType(type) async {
    List<Payment> paymentList = [];
    QuerySnapshot doc = await _databaseReference
        .collection('payment_history')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('type', isEqualTo: type)
        .get();
    doc.docs.forEach((element) {
      paymentList.add(Payment.create(
          amount: int.parse(element.get('amount')),
          title: element.get('title'),
          type: element.get('type'),
          id: element.get('id')));
    });
    return paymentList;
  }

  Future<int> getCurrentAmount() async {
    DocumentSnapshot doc = await _databaseReference
        .collection('money_status')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    return doc.get('amount');
  }

  void addAmount(title, amount, uid) async {
    int newAmount = await getCurrentAmount() + int.parse(amount);

    _databaseReference
        .collection('money_status')
        .doc(uid)
        .set({'amount': newAmount});
    addPaymentToHistory(title, amount, 'added', uid);
  }

  void removeAmount(title, amount, uid) async {
    int newAmount = await getCurrentAmount() - int.parse(amount);

    _databaseReference
        .collection('money_status')
        .doc(uid)
        .set({'amount': newAmount});
    addPaymentToHistory(title, amount, 'removed', uid);
  }

  void addPaymentToHistory(title, amount, type, uid) async {
    _databaseReference
        .collection('payment_history')
        .add({'title': title, 'amount': amount, 'uid': uid, 'type': type}).then(
            (value) {
      _databaseReference
          .collection('payment_history')
          .doc(value.id)
          .update({'id': value.id});
    });
  }

  void validatePayment(username, reason, amount) async {
    if (await doesHaveEnoughFounds(amount)) {
      List userInfo = await usernameExists(username);
      if (userInfo.first != 'not-found') {
        removeAmount(reason, amount, FirebaseAuth.instance.currentUser.uid);
        print(userInfo.first);
        addAmount(reason, amount, userInfo.first);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavigationPage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Korisnik nije pronadjen')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Nemate dovoljno sredstava')));
    }
  }

  Future<bool> doesHaveEnoughFounds(amount) async {
    if (await getCurrentAmount() - int.parse(amount) > 0) {
      return true;
    } else
      return false;
  }

  Future<List<String>> usernameExists(username) async {
    QuerySnapshot doc = await _databaseReference
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    List<String> userInfo;
    if (doc.docs.isEmpty) {
      userInfo = ['not-found', 'not-found'];
    } else {
      userInfo = [doc.docs.first['uid'], doc.docs.first['username']];
    }
    return userInfo;
  }
}
