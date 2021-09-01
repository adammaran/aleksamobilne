class Payment {
  Payment.create({this.amount, this.title, this.type, this.id});

  final int amount;
  final String title;
  final String type;
  final String id;
}
