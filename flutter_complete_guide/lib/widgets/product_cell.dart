import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_state.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class ProductCell extends StatelessWidget {
  final Product product;

  ProductCell({@required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: Key(product.id),
      create: (_) => ProductItemBloc(
        product: product,
        productBloc: context.bloc<ProductBloc>(),
      ),
      child: BlocConsumer<ProductItemBloc, ProductItemState>(
        listener: (_, cur) {
          if (cur is ProductItemSetFavoriteFailedState) {
            Scaffold.of(context)?.showSnackBar(
              SnackBar(
                content: Text(cur.responseErrorState.errorMessage),
              ),
            );
          }
        },
        buildWhen: (_, cur) {
          return (cur is ProductItemReadyState);
        },
        builder: (ctx, state) {
          Product product;
          if (state is ProductItemReadyState) {
            product = state.product;
          }

          return Card(
            key: Key(product.id),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridTile(
                footer: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(5),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          product.title,
                          style: context.theme.textTheme.title.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Container(
                        width: 35,
                        child: IconButton(
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          icon: product.isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            ctx.bloc<ProductItemBloc>().add(
                                  SetFavoriteEvent(
                                      isFavorite: !product.isFavorite),
                                );
                          },
                        ),
                      ),
                      Container(
                        width: 35,
                        child: IconButton(
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            ctx.bloc<CartBloc>().add(
                                  AddProductToCartEvent(product: product),
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      product.imageUrl,
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
