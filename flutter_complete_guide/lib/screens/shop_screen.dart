import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('All'),
                  height: 40,
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Favorite'),
                  height: 40,
                )
              ];
            },
            onSelected: (index) {
              if (index == 1) {
                context.bloc<ProductBloc>().add(ProductFilterFavoriteEvent());
              } else {
                context.bloc<ProductBloc>().add(ProductFilterAllEvent());
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (ctx, state) {
          if (state is ProductLoadedState) {
            return state.products.isEmpty
                ? Center(
                    child: Text('Product is empty'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 2.3,
                    ),
                    itemBuilder: (ctx, index) {
                      return _productCell(state.products[index]);
                    },
                    itemCount: state.products.length,
                  );
          } else {
            return Center(
              child: Text('Product is empty'),
            );
          }
        },
      ),
    );
  }

  Widget _productCell(Product product) {
    return BlocProvider(
      key: Key(product.id),
      create: (_) => ProductItemBloc(
        product: product,
        productBloc: context.bloc<ProductBloc>(),
      ),
      child: BlocBuilder<ProductItemBloc, Product>(
        builder: (ctx, state) {
          print('rebuild product item ${state.id}');
          return Card(
            key: Key(state.id),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridTile(
                footer: Container(
                  padding: const EdgeInsets.all(5),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          state.description,
                          style: context.theme.textTheme.title.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: state.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.redAccent,
                              ),
                        onPressed: () {
                          ctx.bloc<ProductItemBloc>().add(
                                SetFavoriteEvent(isFavorite: !state.isFavorite),
                              );
                        },
                      ),
                    ],
                  ),
                  color: Colors.black45,
                ),
                child: Container(
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      state.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    FlatButton(
                      onPressed: () {
                        context.navigator.pushNamed(
                          '/shop-detail-screen',
                          arguments: ctx.bloc<ProductItemBloc>(),
                        );
                      },
                      child: Container(
                        child: null,
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
