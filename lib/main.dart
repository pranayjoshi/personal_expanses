// ignore_for_file: sort_child_properties_last, deprecated_member_use
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/widgets/user_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 99.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "New Groceries", amount: 98.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  bool _ShowChart = false;

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx){return GestureDetector(onTap: () {}, child: NewTransaction(_addUserTransaction), behavior: HitTestBehavior.opaque,);});
  }

  
  void _addUserTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        amount: amount,
        date: date,
        id: DateTime.now().toString(),
        title: title);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteUserTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
        title: Text("Personal Expenses"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.white), onPressed: (){_startAddNewTransaction(context);})
        ],
      );
    final txList = Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: TransactionList(_userTransactions, _deleteUserTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[

            if (_isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Show Chart"),
                Switch.adaptive(value: _ShowChart, onChanged: (val) {
                  setState(() {
                    _ShowChart = val;
                  });
                })
              ],),

              if (!_isLandscape)
                Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions)),
              if (!_isLandscape) txList
              else _ShowChart ? Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: Chart(_recentTransactions)) : txList,
            ]),
              
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: const Icon(Icons.add, color: Colors.white,)),
    );
  }
}
