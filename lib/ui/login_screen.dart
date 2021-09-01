import 'package:e_banking/repository/UserRepository.dart';
import 'package:e_banking/ui/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        padding: EdgeInsets.only(top: 24, left: 40, right: 40),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "email",
              ),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Šifra",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UserRepository userRepo = UserRepository();
                userRepo.loginUser(
                    emailController.text, passwordController.text, context);
              },
              child: Text("Uloguj se"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text("Kreirajte novi nalog",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            )
          ],
        ),
      ),
    );
  }
}
