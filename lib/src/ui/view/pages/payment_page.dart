import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/cart_view_model.dart';
import 'package:e_commerce_project/src/view_model/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class PaymentPage extends StatelessWidget implements AutoRouteWrapper {
  PaymentPage({super.key, required this.viewModel});
  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderViewModel(),
      child: this,
    );
  }

  final CartViewModel viewModel;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _creditCardNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool? isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Toplam Tutar : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "${viewModel.totalPrice.toStringAsFixed(2).toString()} TL",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card),
                      Text(
                          'Lütfen kredi veya banka kart bilgilerinizi giriniz.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kart sahibinin adı soyadı',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _creditCardNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen kart numaranızı giriniz.';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kart numarası',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                labelText: 'AA/YY',
                                border: OutlineInputBorder(),
                                counterText: '',
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 5,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tarih boş bırakılamaz';
                                } else if (value.length < 5) {
                                  return 'Geçerli bir tarih girin';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.length == 2 &&
                                    !_dateController.text.contains('/')) {
                                  _dateController.text = value + '/';
                                  _dateController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _dateController.text.length));
                                } else if (value.length == 2 &&
                                    _dateController.text.contains('/')) {
                                  _dateController.text = value.substring(0, 1);
                                  _dateController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _dateController.text.length));
                                } else if (value.length == 3 &&
                                    !_dateController.text.contains('/')) {
                                  _dateController.text = value.substring(0, 2) +
                                      '/' +
                                      value.substring(2);
                                  _dateController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _dateController.text.length));
                                }
                              },
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                              flex: 8,
                              child: TextFormField(
                                  controller: _cvvController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'CVV Boş bırakılamaz';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'CVV',
                                      border: OutlineInputBorder())))
                        ],
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     _buildCheckBox(),
                //     Text('Kartımı kaydet.'),
                //   ],
                // ),
                // Row(
                //   children: [
                //     _buildCheckBox(),
                //     Text('Hüküm ve koşulları kabul ediyorum.'),
                //   ],
                // ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      showToast(message: "Lütfen gerekli alanları doldurunuz!");
                    } else {
                      context.router.push(OrderRoute());
                      OrderViewModel orderViewModel =
                          Provider.of<OrderViewModel>(context, listen: false);
                      orderViewModel.addCurrentCartItemsToOrder();
                      print("girdi");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Ödeme Yap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.black;
  }

  // Widget _buildCheckBox() {
  //   return Checkbox(
  //     checkColor: Colors.white,
  //     fillColor: MaterialStateProperty.resolveWith(getColor),
  //     value: isChecked,
  //     onChanged: (bool? value) {
  //       // setState(() {
  //       //   isChecked = value!;
  //       // });
  //     },
  //   );
  // }
}
