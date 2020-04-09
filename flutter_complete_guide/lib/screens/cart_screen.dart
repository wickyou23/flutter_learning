import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_event.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_state.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_event.dart';
import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listener: (_, state) {
            if (state is CartReadyState) {
              if (state.cart.cartItems.isEmpty) {
                context.navigator.pop();
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Container(
          color: Colors.grey.withPercentAlpha(0.1),
          child: Column(
            children: <Widget>[
              Expanded(child: _cartItemList()),
              Container(
                height: 110,
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0),
                  ),
                ),
                child: _bottomWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartItemList() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (ctx, state) {
        List<CartItem> _cartItem = [];
        if (state is CartReadyState) {
          _cartItem = state.cart.cartItems.values.toList();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          itemCount: _cartItem.length,
          itemBuilder: (ctx, index) {
            CartItem item = _cartItem[index];
            return Column(
              children: <Widget>[
                Dismissible(
                  key: Key('${item.productId}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.redAccent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey.withPercentAlpha(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Image.network(
                                item.product.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            item.product.title,
                            style: context.theme.textTheme.title.copyWith(
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(
                            '\$${item.getSumMoney().toStringAsFixed(2)}',
                            style: context.theme.textTheme.title.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          trailing: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.add_circle),
                                    iconSize: 24,
                                    color: context.theme.primaryColor,
                                    onPressed: () {
                                      context.bloc<CartBloc>().add(
                                            AddProductToCartEvent(
                                                product: item.product),
                                          );
                                    },
                                  ),
                                ),
                                Container(
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Colors.grey.withPercentAlpha(0.4),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'x${item.quantity}',
                                      style: context.theme.textTheme.title
                                          .copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 24,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.remove_circle),
                                    iconSize: 24,
                                    color: context.theme.primaryColor,
                                    onPressed: () async {
                                      bool allowDelete = true;
                                      if (item.quantity == 1) {
                                        allowDelete = await _showAlertConfirm();
                                      }

                                      if (allowDelete) {
                                        context.bloc<CartBloc>().add(
                                              RemoveProductToCartEvent(
                                                  product: item.product),
                                            );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (_) {
                    return _showAlertConfirm();
                  },
                  onDismissed: (_) {
                    context.bloc<CartBloc>().add(
                          ForceRemoveProductToCartEvent(product: item.product),
                        );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _bottomWidget() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (ctx, state) {
        if (state is CartReadyState) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total:',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${state.cart.getSumMoney().toStringAsFixed(2)}',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                  color: context.theme.primaryColor,
                  child: Text(
                    'Order Now',
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    context.bloc<TransactionBloc>().add(
                          AddNewTransacionEvent(cart: state.cart),
                        );
                  },
                ),
              )
            ],
          );
        } else {
          return Container(
            width: 0,
            height: 0,
          );
        }
      },
    );
  }

  Future<bool> _showAlertConfirm() {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Container(
            height: 50,
            color: Colors.redAccent,
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Confirm',
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          titlePadding: EdgeInsets.zero,
          content: Text(
            'Do you to remove this item?',
            style: context.theme.textTheme.title.copyWith(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 15,
                  color: context.theme.primaryColor,
                ),
              ),
              onPressed: () {
                context.navigator.pop(false);
              },
            ),
            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.redAccent,
              child: Text(
                'DELETE',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                context.navigator.pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
