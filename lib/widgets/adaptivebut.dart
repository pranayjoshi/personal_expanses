import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final void Function() handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isIOS ? CupertinoButton(
                          child: Text(text),
                          onPressed: handler)
                      : TextButton(
                          onPressed: handler,
                          child: Text(text))
    );
  }
}