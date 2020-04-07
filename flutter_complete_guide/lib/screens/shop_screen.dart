import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  ProductBloc _productBloc;
  ProductRepository _productRepository;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository();
    _productBloc = ProductBloc(productRepository: _productRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: BlocProvider.value(
        value: _productBloc,
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBloc,
          builder: (_, state) {
            if (state is ProductLoadedState) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  return _productCell(state.products[index]);
                },
              );
            } else {
              return Center(
                child: Text('Product is empty'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _productCell(Product product) {
    return BlocProvider(
      create: (_) => ProductItemBloc(product: product),
      child: BlocBuilder<ProductItemBloc, Product>(
        builder: (ctx, state) {
          return ListTile(
            title: Text(state.description),
            trailing: IconButton(
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
                BlocProvider.of<ProductItemBloc>(ctx).add(
                  SetFavoriteEvent(isFavorite: !state.isFavorite),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
