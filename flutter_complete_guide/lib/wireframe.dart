import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/bloc/repository/transaction_repository.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/product_managed_screen.dart';
import 'package:flutter_complete_guide/screens/shop_detail_screen.dart';
import 'package:flutter_complete_guide/screens/shop_screen.dart';
import 'package:flutter_complete_guide/screens/transaction_history_screen.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => BlocProvider(
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
    '/edit-product-managed-creen': (ctx) => BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          ),
          child: EditProductScreen(),
        ),
  };
}
