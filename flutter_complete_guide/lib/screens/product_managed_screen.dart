import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/screens/left_menu_drawer.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class ProductManagedScreen extends StatefulWidget {
  @override
  _ProductManagedScreenState createState() => _ProductManagedScreenState();
}

class _ProductManagedScreenState extends State<ProductManagedScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void> _refreshCompleter;
  bool _isFirstLoad = true;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isFirstLoad) {
        _refreshKey.currentState.show();
        context.bloc<ProductBloc>().add(GetAllProductEvent());
        _isFirstLoad = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Managed'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.navigator.pushNamed('/edit-product-creen',
                  arguments: {'bloc': context.bloc<ProductBloc>()});
            },
          )
        ],
      ),
      drawer: Drawer(
        child: LeftMenuDrawer(),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (pre, cur) {
            if (cur is ProductLoadedState) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
          },
          buildWhen: (_, state) {
            return (state is ProductLoadedState ||
                state is DeletingProductState);
          },
          builder: (_, state) {
            if (state is ProductLoadedState) {
              _products = state.products;
            }

            String productIdDeleting = '';
            if (state is DeletingProductState) {
              productIdDeleting = state.productId;
            }

            return RefreshIndicator(
              key: _refreshKey,
              child: ListView.separated(
                itemCount: _products.length,
                itemBuilder: (_, index) {
                  final item = _products[index];
                  return Container(
                    height: 80,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 16.0, right: 10.0),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withPercentAlpha(0.5),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: context.theme.textTheme.title.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        trailing: (productIdDeleting == item.id)
                            ? Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: context.theme.primaryColor,
                                      onPressed: productIdDeleting.isNotEmpty
                                          ? null
                                          : () {
                                              context.navigator.pushNamed(
                                                  '/edit-product-creen',
                                                  arguments: {
                                                    'bloc': context
                                                        .bloc<ProductBloc>(),
                                                    'product': item,
                                                  });
                                            },
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.redAccent,
                                      onPressed: productIdDeleting.isNotEmpty
                                          ? null
                                          : () async {
                                              var isRemove = await context
                                                  .showAlertConfirm();
                                              if (isRemove) {
                                                context.bloc<ProductBloc>().add(
                                                      DeleteProductEvent(
                                                          productId: item.id),
                                                    );
                                              }
                                            },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, idx) {
                  return Divider(
                    height: 1,
                    color: Colors.grey.withPercentAlpha(0.5),
                    indent: 16,
                  );
                },
              ),
              onRefresh: () async {
                context.bloc<ProductBloc>().add(GetAllProductEvent());
                return _refreshCompleter.future;
              },
            );
          },
        ),
      ),
    );
  }
}
