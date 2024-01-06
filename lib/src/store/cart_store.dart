import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

@singleton
class CartStore extends _CartStore with _$CartStore {}

abstract class _CartStore with Store {
  @observable
  double totalPrice = 0;

  @action
  void setTotalPrice(List<Map<String, dynamic>> carts) {
    totalPrice = 0;

    for (Map<String, dynamic> cartItem in carts) {
      // totalPrice += cartItem['price'] * cartItem['quantity'];
      totalPrice += cartItem['price'];
    }
  }
}
