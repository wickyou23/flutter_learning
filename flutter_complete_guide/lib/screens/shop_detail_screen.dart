import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_state.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_bloc.dart';
import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class ShopDetailScreen extends StatefulWidget {
  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _heightHeader = 250;
  double _heightAppBar = 60;
  double _heightDefaultAppBar = 60;
  bool _isSwitchAppBar = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final double offset = max(0, _scrollController.offset);
      double appbarOpacity =
          min(offset / (_heightHeader - _heightAppBar + 20), 1);
      if (appbarOpacity >= 0.9 != _isSwitchAppBar) {
        setState(() {
          _isSwitchAppBar = appbarOpacity >= 0.9;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _heightAppBar = context.media.viewPadding.top + _heightDefaultAppBar;
    return BlocProvider.value(
      value: context.routeArg as ProductItemBloc,
      child: BlocBuilder<ProductItemBloc, Product>(
        builder: (ctx, state) {
          return Scaffold(
            body: Stack(
              children: [
                _contentWidget(state),
                _bottomWidget(state),
                AnimatedOpacity(
                  opacity: _isSwitchAppBar ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: _mainAppBar(state),
                ),
                AnimatedOpacity(
                  opacity: _isSwitchAppBar ? 0 : 1,
                  duration: Duration(milliseconds: 200),
                  child: _subAppBar(state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _mainAppBar(Product product) {
    return Container(
      key: Key('_mainAppBar_'),
      color: context.theme.primaryColor,
      height: _heightAppBar,
      child: Container(
        height: _heightDefaultAppBar,
        margin: EdgeInsets.only(top: context.media.viewPadding.top),
        padding: const EdgeInsets.only(right: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              iconSize: 28,
              onPressed: () {
                context.navigator.pop();
              },
            ),
            Text(
              product.title,
              style: context.theme.textTheme.title.copyWith(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.white,
              iconSize: 28,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _subAppBar(Product product) {
    return Container(
      key: Key('_subAppBar_'),
      height: _heightAppBar + 16,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(
              top: context.media.viewPadding.top + 16.0,
              left: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withPercentAlpha(0.8),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                context.navigator.pop();
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(
              top: context.media.viewPadding.top + 16.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withPercentAlpha(0.8),
            ),
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomWidget(Product product) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (ctx, state) {
        CartItem cartItem;
        if (state is CartReadyState) {
          cartItem = state.cart.getCartItemByProductId(product.id);
          _quantity = cartItem?.quantity ?? 1;
        }

        return Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              padding: const EdgeInsets.only(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: context.theme.primaryColor,
                          iconSize: 35,
                          onPressed: () {
                            if (_quantity != 1) {
                              setState(() {
                                _quantity -= 1;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$_quantity',
                          style: context.theme.textTheme.title.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle),
                          color: context.theme.primaryColor,
                          iconSize: 35,
                          onPressed: () {
                            setState(() {
                              _quantity += 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    child: RaisedButton(
                      child: Text(
                        'ADD TO CART - \$${(_quantity.toDouble() * product.price).toStringAsFixed(2)}',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: context.theme.primaryColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _contentWidget(Product product) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: _SliverPersistentHeader(
            product: product,
            heightAppBar: _heightAppBar,
          ),
          pinned: true,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Price:   ',
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${product.price}',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.description,
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double heightAppBar;
  final Product product;

  _SliverPersistentHeader({
    @required this.product,
    this.heightAppBar = 80,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.redAccent,
      height: double.infinity,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 0;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
