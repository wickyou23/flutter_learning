import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/redux/app_state.dart';
import 'package:flutter_complete_guide/screens/shop_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ShopViewModel>(
      distinct: true,
      converter: (store) => ShopViewModel.fromStore(store),
      builder: (ctx, vm) {
        print('_ShopScreenState rebuild');
        return Scaffold(
          body: Container(
            child: ListView.builder(
              itemCount: vm.products.length,
              itemBuilder: (ctx, index) {
                final item = vm.products.values.elementAt(index);
                return Card(
                  child: Container(
                    height: 50,
                    child: ListTile(
                      title: Text(item.description),
                      trailing: IconButton(
                        icon: item.isFavorite
                            ? Icon(Icons.help)
                            : Icon(Icons.help_outline),
                        onPressed: () {
                          item.isFavorite = !item.isFavorite;
                          vm.setFavorite(item);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
