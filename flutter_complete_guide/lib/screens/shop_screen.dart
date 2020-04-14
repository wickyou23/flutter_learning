import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_state.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/screens/left_menu_drawer.dart';
import 'package:flutter_complete_guide/utils/extension.dart';
import 'package:flutter_complete_guide/widgets/product_cell.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop App',
          style: context.theme.textTheme.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    'All',
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  height: 40,
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    'Favorite',
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 16,
                    ),
                  ),
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
                      return ProductCell(product: state.products[index]);
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
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (ctx, state) {
          if (state is CartReadyState && state.cart.quantity != 0) {
            return FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      height: 16,
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.redAccent,
                      ),
                      child: Text(
                        '${state.cart.quantity}',
                        style: context.theme.textTheme.title.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                context.navigator.pushNamed('/cart-screen');
              },
            );
          }

          return Container(
            width: 0,
            height: 0,
          );
        },
      ),
      drawer: Drawer(
        child: LeftMenuDrawer(),
      ),
    );
  }
}
