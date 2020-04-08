import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class ShopDetailScreen extends StatefulWidget {
  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.routeArg as ProductItemBloc,
      child: BlocBuilder<ProductItemBloc, Product>(
        builder: (ctx, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.title),
              actions: <Widget>[
                IconButton(
                  icon: state.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    ctx.bloc<ProductItemBloc>().add(
                          SetFavoriteEvent(isFavorite: !state.isFavorite),
                        );
                  },
                )
              ],
            ),
            body: Container(child: null),
          );
        },
      ),
    );
  }
}
