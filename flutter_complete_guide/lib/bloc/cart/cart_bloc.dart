import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_event.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_state.dart';
import 'package:flutter_complete_guide/bloc/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRep;

  CartBloc({@required this.cartRep});

  @override
  CartState get initialState => CartReadyState(cart: cartRep.currentCart);

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddProductToCartEvent) {
      yield* _mapToAddProductEvent(event);
    } else if (event is RemoveProductToCartEvent) {
      yield* _mapToRemoveProductEvent(event);
    } else if (event is ForceRemoveProductToCartEvent) {
      yield* _mapToForceRemoveProductEvent(event);
    } else if (event is ClearCardEvent) {
      yield* _mapToClearCartEvent();
    }
  }

  @override
  Future<void> close() {
    print('CartBloc closed');
    return super.close();
  }

  Stream<CartState> _mapToAddProductEvent(AddProductToCartEvent event) async* {
    var crState = state;
    if (crState is CartReadyState) {
      cartRep.addProduct(event.product);
      yield CartReadyState(cart: cartRep.currentCart.copyWith());
    }
  }

  Stream<CartState> _mapToRemoveProductEvent(RemoveProductToCartEvent event) async* {
    var crState = state;
    if (crState is CartReadyState) {
      cartRep.removeProduct(event.product);
      yield CartReadyState(cart: cartRep.currentCart.copyWith());
    }
  }

  Stream<CartState> _mapToForceRemoveProductEvent(ForceRemoveProductToCartEvent event) async* {
    var crState = state;
    if (crState is CartReadyState) {
      cartRep.forceRemoveProduct(event.product);
      yield CartReadyState(cart: cartRep.currentCart.copyWith());
    }
  }

  Stream<CartState> _mapToClearCartEvent() async* {
    var crState = state;
    if (crState is CartReadyState) {
      cartRep.clear();
      yield CartReadyState(cart: cartRep.currentCart.copyWith());
    }
  }
}
