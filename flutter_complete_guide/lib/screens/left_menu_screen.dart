import 'package:flutter/material.dart';

import '../utils/extension.dart';

class LeftMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: context.media.size.width,
            height: (context.media.size.height * 0.2),
            color: context.theme.primaryColor.withPercentAlpha(0.5),
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Delli Meal App!',
              style: context.theme.textTheme.title.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              context.navigator.pushReplacementNamed('/');
            },
          ),
          Divider(
            height: 2,
            indent: 16,
          ),
          ListTile(
            leading: Icon(Icons.filter_vintage),
            title: Text('Filter'),
             onTap: () {
               context.navigator.pushReplacementNamed('/filter');
             },
          ),
          Divider(height: 2, indent: 16),
        ],
      ),
    );
  }
}
