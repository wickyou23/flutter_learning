import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';
import 'package:flutter_complete_guide/data/repository/transaction_repository.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/screens/authentication_screen.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/product_managed_screen.dart';
import 'package:flutter_complete_guide/screens/shop_detail_screen.dart';
import 'package:flutter_complete_guide/screens/shop_screen.dart';
import 'package:flutter_complete_guide/screens/transaction_history_screen.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/dashboard': (_) => BlocProvider(
          create: (_) => ProductBloc(productRepository: ProductRepository()),
          child: ShopScreen(),
        ),
    '/shop-detail-screen': (ctx) => ShopDetailScreen(),
    '/cart-screen': (_) => BlocProvider(
          create: (ctx) => TransactionBloc(
            repository: TransactionRepository(),
            cartBloc: ctx.bloc<CartBloc>(),
          ),
          child: CartScreen(),
        ),
    '/transaction-history-screen': (ctx) => BlocProvider(
          create: (_) => TransactionBloc(repository: TransactionRepository()),
          child: TransactionHistoryScreen(),
        ),
    '/product-managed-screen': (ctx) => BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          ),
          child: ProductManagedScreen(),
        ),
    '/edit-product-creen': (ctx) {
      Map<String, Object> args = ctx.routeArg as Map<String, Object>;
      return BlocProvider.value(
        value: args['bloc'] as ProductBloc,
        child: EditProductScreen(crProduct: args['product'] as Product),
      );
    },
  };
}
