import 'package:e_banking/ui/balance_screen.dart';
import 'package:e_banking/ui/login_screen.dart';
import 'package:e_banking/ui/payment_history_screen.dart';
import 'package:e_banking/ui/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigacija'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            child: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentScreen()));
                  },
                  child: Text('Plaćanje')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BalanceScreen()));
                  },
                  child: Text('Trenutno stanje')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentHistoryScreen()));
                  },
                  child: Text('Istorija plaćanja')),
            ],
          ),
        ),
      ),
    );
  }
}
