import 'package:e_banking/repository/PaymentRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaymentHistoryScreenState();
}

class PaymentHistoryScreenState extends State<PaymentHistoryScreen> {


  @override
  Widget build(BuildContext context) {
    PaymentRepository paymentRepo = PaymentRepository();
    return Scaffold(
        appBar: AppBar(
          title: Text("Istorija plaćanja"),
        ),
        body: Container(
          child: FutureBuilder(
              future: paymentRepo.getPaymentList(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snap.data.length,
                            itemBuilder: (_, index) {
                              return Card(
                                child: ListTile(
                                  title: Center(
                                      child: Column(
                                    children: [
                                      Text(snap.data.elementAt(index).title),
                                      snap.data.elementAt(index).type == "added"
                                          ? Text(
                                              "+ ${snap.data.elementAt(index).amount.toString()}",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "- ${snap.data.elementAt(index).amount.toString()}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )
                                    ],
                                  )),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
