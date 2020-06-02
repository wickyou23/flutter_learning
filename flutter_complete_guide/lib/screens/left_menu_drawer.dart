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
              _setupRow(
                context,
                title: 'Home',
                icon: Icon(Icons.home),
                onPressed: () {
                  if (context.route.settings.name == '/dashboard') {
                    context.navigator.pop();
                  } else {
                    context.navigator.pushReplacementNamed('/dashboard');
                  }
                },
              ),
              Divider(
                height: 1,
                color: Colors.grey.withPercentAlpha(0.4),
              ),
              _setupRow(
                context,
                title: 'History',
                icon: Icon(Icons.history),
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
              _setupRow(
                context,
                title: 'Setting',
                icon: Icon(Icons.settings),
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
              _setupRow(
                context,
                title: 'Logout',
                icon: Icon(Icons.exit_to_app),
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

  Widget _setupRow(BuildContext context, {String title, Icon icon, Function onPressed}) {
    return FlatButton(
      child: Container(
        height: 60,
        width: double.infinity,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: context.theme.textTheme.title.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
