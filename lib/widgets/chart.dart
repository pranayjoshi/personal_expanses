import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++){
        if (recentTransactions[i].date.day == weekDay.day && recentTransactions[i].date.month == weekDay.month && recentTransactions[i].date.year == weekDay.year){
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay).substring(0,1));
      print(totalSum);
      return {
        "day": DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum
      };
    });
  }

  double get MaxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {

    print(groupedTransactionValues);
    return Card(elevation: 6, margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: groupedTransactionValues.map((data) {
          return Flexible (
            fit: FlexFit.tight,
            child: ChartBar(
              (data["day"] as String), 
              (data["amount"] as double),
              MaxSpending == 0.0 ? 0.0 : ((data["amount"] as double) / MaxSpending)
            ));
        }).toList()),
      ),
    );
  }
}