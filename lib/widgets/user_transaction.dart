// import 'package:flutter/material.dart';
// import 'package:personal_expenses/widgets/new_transaction.dart';
// import 'package:personal_expenses/widgets/transaction_list.dart';

// import '../models/transaction.dart';

// class UserTransaction extends StatefulWidget {
//   const UserTransaction({Key? key}) : super(key: key);

//   @override
//   State<UserTransaction> createState() => _UserTransaction();
// }

// class _UserTransaction extends State<UserTransaction> {
//   final List<Transaction> _userTransaction = [
//     Transaction(
//         id: "t1", title: "New Shoes", amount: 99.99, date: DateTime.now()),
//     Transaction(
//         id: "t1", title: "New Groceries", amount: 98.99, date: DateTime.now()),
//   ];

//   void _addUserTransaction(String title, double amount) {
//     final newTx = Transaction(
//         amount: amount,
//         date: DateTime.now(),
//         id: DateTime.now().toString(),
//         title: title);
//     setState(() {
//       _userTransaction.add(newTx);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[NewTransaction(_addUserTransaction), TransactionList(_userTransaction)],
//     );
//   }
// }
