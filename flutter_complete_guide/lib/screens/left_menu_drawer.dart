import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/utils/extension.dart';
import 'package:flutter_complete_guide/wireframe.dart';

class LeftMenuDrawer extends StatelessWidget {
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
                  height: 60,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Home',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (context.route.settings.name == '/') {
                    context.navigator.pop();
                  } else {
                    context.navigator.pushReplacementNamed('/');
                  }
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
              FlatButton(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.history),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'History',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (context.route.settings.name ==
                      '/transaction-history-screen') {
                    context.navigator.pop();
                  } else {
                    context.navigator
                        .pushReplacementNamed('/transaction-history-screen');
                  }
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
              FlatButton(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Setting',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (context.route.settings.name ==
                      '/product-managed-screen') {
                    context.navigator.pop();
                  } else {
                    context.navigator
                        .pushReplacementNamed('/product-managed-screen');
                  }
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
              FlatButton(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  AppWireFrame.logout();
                  context.navigator.pushReplacementNamed('/authentication');
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
