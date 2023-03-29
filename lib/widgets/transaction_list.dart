import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  // ignore: use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    

    return Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            var tx = transactions[index];
            return TransactionItem(transactions: transactions[index], deleteTx: deleteTx);
          },
          itemCount: transactions.length,
        ));
  }
}





// Card(
//               child: Row(children: <Widget>[
//                 Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Theme.of(context).primaryColor),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Text(
//                     "\$${tx.amount.toStringAsFixed(2)}",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Theme.of(context).primaryColor),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       tx.title,
//                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                     ),
//                     Text(
//                       DateFormat.yMMMMd('en_US').format(tx.date),
//                       style: const TextStyle(color: Colors.grey),
//                     )
//                   ],
//                 )
//               ]),
//             );