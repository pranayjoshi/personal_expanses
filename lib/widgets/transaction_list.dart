import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;

  // ignore: use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {

    final delIcon = (index) => IconButton(icon: Icon(Icons.delete), onPressed: () { return deleteTx(transactions[index].id);}, color: Theme.of(context).colorScheme.error,);
    final FlatIcon = (index) => ElevatedButton.icon(icon: Icon(Icons.delete), label: Text("Delete"), onPressed: () { return deleteTx(transactions[index].id);}, style: TextButton.styleFrom(

        foregroundColor: Theme.of(context).colorScheme.error,
        backgroundColor: Colors.white
      ),);


    return  Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var tx = transactions[index];
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
                    padding:EdgeInsets.all(6), 
                    child: FittedBox(
                      child: Text('\$${transactions[index].amount}')
                    )
                  ),
                ),
                title: Text(
                  transactions[index].title
                ),
                subtitle: Text(
                        DateFormat.yMMMMd('en_US').format(tx.date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                trailing: MediaQuery.of(context).size.width > 360 ? FlatIcon(index) : delIcon(index),
              ),
            );
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