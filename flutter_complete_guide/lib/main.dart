import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/auth/auth_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/data/repository/auth_repository.dart';
import 'package:flutter_complete_guide/data/repository/cart_repository.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';
import 'package:flutter_complete_guide/screens/authentication_screen.dart';
import 'package:flutter_complete_guide/screens/shop_screen.dart';
import 'package:flutter_complete_guide/services/navigation_service.dart';
import 'package:flutter_complete_guide/wireframe.dart';
import 'bloc/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';

// import 'package:flutter/services.dart';

void main() {
  // Lock Orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(cartRep: CartRepository()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        navigatorKey: NavigationService().navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'NunitoSans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'NunitoSans',
                ),
              ),
        ),
        home: FutureBuilder(
          future: AuthRepository().getCurrentUser(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return BlocProvider(
                  create: (_) => ProductBloc(
                    productRepository: ProductRepository(),
                  ),
                  child: ShopScreen(),
                );
              } else {
                return AuthenticationScreen();
              }
            } else {
              return Container(
                color: Colors.white,
              );
            }
          },
        ),
        routes: AppWireFrame.routes,
      ),
    );
  }
}
