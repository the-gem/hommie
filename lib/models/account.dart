import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  int balance;
  Account({
    this.balance
  });

  factory Account.fromDocument(DocumentSnapshot doc) {
    return Account(
      balance: doc["wallet"],
    );
  }
}
