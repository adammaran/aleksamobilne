import 'package:e_banking/repository/UserRepository.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Registracija")),
      body: Container(
        padding: EdgeInsets.only(top: 24, left: 40, right: 40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "email",
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: "Korisničko ime"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Šifra",
              ),
            ),
            TextField(
              controller: rePasswordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Ponoviti Šifru"),
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text == rePasswordController.text) {
                  UserRepository userRepo = UserRepository();
                  userRepo.createStudent(
                      emailController.text,
                      passwordController.text,
                      usernameController.text,
                      context);
                } else {
                  final snackBar =
                  SnackBar(content: Text('Šifre se ne poklapaju'));
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              },
              child: Text("Registruj se"),
            ),
          ],
        ),
      ),
    );
  }
}