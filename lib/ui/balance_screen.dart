import 'package:e_banking/repository/PaymentRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentRepository paymentRepo = PaymentRepository();
    return Scaffold(
      appBar: AppBar(title: Text('Stanje')),
      body: Center(
        child: Container(
            child: FutureBuilder(
          future: paymentRepo.getCurrentAmount(),
          builder: (context, snap) {
            print(snap);
            return Column(
              children: [
                Text(
                  snap.data.toString(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
