import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/data/repository/cart_repository.dart';
import 'package:flutter_complete_guide/wireframe.dart';
import 'bloc/simple_bloc_delegate.dart';

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
    return BlocProvider(
      create: (_) => CartBloc(cartRep: CartRepository()),
      child: MaterialApp(
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
        routes: AppWireFrame.routes,
      ),
    );
  }
}
