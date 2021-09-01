import 'package:e_banking/repository/PaymentRepository.dart';
import 'package:e_banking/ui/payment_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentScreen extends StatefulWidget {
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController svrhaController = TextEditingController();
  TextEditingController amountPayment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova uplata')),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'Primalac'),
            ),
            TextField(
              controller: svrhaController,
              decoration: InputDecoration(hintText: 'Svrha uplate'),
            ),
            TextField(
              controller: amountPayment,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Iznost'),
            ),
            ElevatedButton(
                onPressed: () {
                  PaymentRepository paymentRepo =
                      PaymentRepository(context: context);
                  paymentRepo.validatePayment(usernameController.text,
                      svrhaController.text, amountPayment.text);
                },
                child: Text('Plati'))
          ],
        ),
      ),
    );
  }
}
