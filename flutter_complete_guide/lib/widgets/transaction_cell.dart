import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class TransactionCell extends StatefulWidget {
  final Transaction transaction;

  TransactionCell({Key key, this.transaction}) : super(key: key);

  @override
  _TransactionCellState createState() => _TransactionCellState();
}

class _TransactionCellState extends State<TransactionCell>
    with TickerProviderStateMixin {
  bool _isExpaned = false;
  AnimationController _rotateAnimationCL;

  @override
  void initState() {
    super.initState();
    _rotateAnimationCL =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return _transactionCell(widget.transaction);
  }

  Widget _transactionCell(Transaction item) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 16,
              right: 0,
            ),
            title: Text('Payment'),
            subtitle: Text(
              item.createDate.csToString('dd-MM-yyyy HH:mm a'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '\$${item.totalMoney.toStringAsFixed(2)}',
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                AnimatedBuilder(
                  key: Key(item.id),
                  animation: _rotateAnimationCL,
                  builder: (ctx, child) {
                    return Transform.rotate(
                      angle: _rotateAnimationCL.value * (-1.0 * pi),
                      child: child,
                    );
                  },
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                    ),
                    onPressed: () {
                      if (_isExpaned) {
                        _rotateAnimationCL.reverse();
                      } else {
                        _rotateAnimationCL.forward();
                      }

                      setState(() {
                        _isExpaned = !_isExpaned;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          _transactionDetailWidget(item, _isExpaned)
        ],
      ),
    );
  }

  Widget _transactionDetailWidget(Transaction item, bool isExpaned) {
    double estimateHeight = item.transactionDetails.length * 40.0 + 16.0;
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: isExpaned ? estimateHeight : 0,
      child: LayoutBuilder(
        builder: (_, constraint) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 16,
              right: 16,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Divider(
                  height: 1,
                  color: Colors.grey.withPercentAlpha(0.4),
                ),
                SizedBox(
                  height: 8,
                ),
                ...item.transactionDetails.map((v) {
                  return Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: context.theme.primaryColor,
                          ),
                          child: Text(
                            'x${v.quantity}',
                            style: context.theme.textTheme.title.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${v.productName}',
                          style: context.theme.textTheme.title.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          '\$${v.totalMoney}',
                          style: context.theme.textTheme.title.copyWith(
                            fontSize: 15,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          );
        },
      ),
    );
  }
}