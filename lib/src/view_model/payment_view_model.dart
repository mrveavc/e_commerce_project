import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/order_view_model.dart';
import 'package:flutter/material.dart';

class PaymentViewModel with ChangeNotifier {
  bool _isCheckedSaveMyCreditCard = false;
  bool get isCheckedSaveMyCreditCard => _isCheckedSaveMyCreditCard;
  set isCheckedSaveMyCreditCard(value) {
    _isCheckedSaveMyCreditCard = value;

    notifyListeners();
  }

  bool _isCheckedTermsOfUse = false;
  bool get isCheckedTermsOfUse => _isCheckedTermsOfUse;
  set isCheckedTermsOfUse(value) {
    _isCheckedTermsOfUse = value;

    notifyListeners();
  }

  TextStyle termsOfUseStyle = const TextStyle(color: Colors.black);

  void pay(bool isFormValidate, BuildContext context) {
    if (!isFormValidate || !isCheckedTermsOfUse) {
      termsOfUseStyle = isCheckedTermsOfUse
          ? const TextStyle(color: Colors.black)
          : const TextStyle(color: Colors.red);

      notifyListeners();
      showToast(message: "Lütfen gerekli alanları doldurunuz!");
    } else {
      context.router.push(const OrderRoute());
      OrderViewModel ovm = OrderViewModel();
      ovm.moveCurrentCartItemsToOrder();
    }
  }
}
