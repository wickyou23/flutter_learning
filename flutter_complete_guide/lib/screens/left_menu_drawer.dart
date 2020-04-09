import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class LeftMenuDrawerState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Menu'),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              FlatButton(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Home'),
                ),
                onPressed: () {
                  context.navigator.pushReplacementNamed('/');
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
              FlatButton(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('History'),
                ),
                onPressed: () {
                  context.navigator.pushReplacementNamed('/transaction-history-screen');
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
