import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/screens/shop_detail_screen.dart';
import 'package:flutter_complete_guide/screens/shop_screen.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/': (ctx) => BlocProvider(
          create: (_) => ProductBloc(productRepository: ProductRepository()),
          child: ShopScreen(),
        ),
    '/shop-detail-screen': (ctx) => ShopDetailScreen(),
  };
}
