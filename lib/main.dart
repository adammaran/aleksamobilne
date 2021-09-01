import 'package:e_banking/ui/login_screen.dart';
import 'package:e_banking/ui/navigation_screen.dart';
import 'package:e_banking/ui/payment_history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? NavigationPage()
            : LoginScreen());
  }
}
