import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTx;

  

  @override
  Widget build(BuildContext context) {

    delIcon() => IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // ignore: void_checks
            return deleteTx(transactions.id);
          },
          color: Theme.of(context).colorScheme.error,
        );
    FlatIcon() => ElevatedButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () {
            return deleteTx(transactions.id);
          },
          style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              backgroundColor: Colors.white),
        );

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                  child: Text('\$${transactions.amount}'))),
        ),
        title: Text(transactions.title),
        subtitle: Text(
          DateFormat.yMMMMd('en_US').format(transactions.date),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatIcon()
            : delIcon(),
      ),
    );
  }
}