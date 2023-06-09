import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/adaptivebut.dart';
import 'package:personal_expenses/widgets/user_transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTransaction);
  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  DateTime? _selectedDate;
  final _amountInput = TextEditingController();

  void submitData() {
    final title = _titleInput.text;
    final amount = double.parse(_amountInput.text);

    if (_amountInput.text.isEmpty) {
      return;
    }
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      print("object");
      return;
    }
    widget.addTransaction(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleInput,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData()),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null
                          ? "No date chosen!"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate!)}",
                    ),
                  ),
                  AdaptiveFlatButton("Choose Dat!", _presentDatePicker)
                ],
              ),
            ),
            // ignore: avoid_print
            ElevatedButton(
                onPressed: () => submitData(),
                child: const Text("Add Transaction",
                    style: TextStyle(
                        color: Colors.white, backgroundColor: Colors.cyan))),
          ]),
        ),
      ),
    );
  }
}
