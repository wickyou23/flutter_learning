import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/redux/action_report.dart';

class SetFavoriteAction extends Action {
  final Product product;

  SetFavoriteAction({@required this.product, completer})
      : super(completer, 'SetFavoriteAction');
}
