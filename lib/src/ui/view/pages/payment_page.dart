import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/cart_view_model.dart';
import 'package:e_commerce_project/src/view_model/order_view_model.dart';
import 'package:e_commerce_project/src/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class PaymentPage extends StatelessWidget implements AutoRouteWrapper {
  PaymentPage({super.key, required this.viewModel});

  final CartViewModel viewModel;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _creditCardNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel())
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card),
                      Text(' Lütfen kredi/banka kart bilgilerinizi giriniz.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kart sahibinin adı soyadı',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen kart sahibinin ad ve soyad bilgilerini giriniz.';
                          }
                          return null;
                        },
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
                                  return 'Son kullanım tarihini giriniz.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.length == 3 &&
                                    !_dateController.text.contains('/')) {
                                  _dateController.text =
                                      '${value.substring(0, 2)}/${value.substring(2)}';
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
                                      return 'CVV numarasını giriniz.';
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
              ),
              Consumer<PaymentViewModel>(
                builder: (context, payViewModel, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: AppColor.whiteColor,
                            fillColor: const MaterialStatePropertyAll(
                                AppColor.primaryColor),
                            value: payViewModel.isCheckedSaveMyCreditCard,
                            onChanged: (value) {
                              payViewModel.isCheckedSaveMyCreditCard = value;
                            },
                          ),
                          const Text('Kartımı kaydet.'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: AppColor.whiteColor,
                            fillColor: const MaterialStatePropertyAll(
                                AppColor.primaryColor),
                            value: payViewModel.isCheckedTermsOfUse,
                            onChanged: (value) {
                              payViewModel.isCheckedTermsOfUse = value;
                            },
                          ),
                          Text(
                            'Kullanım koşullarını kabul ediyorum.',
                            style: payViewModel.termsOfUseStyle,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFE5DFDF))),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Toplam Tutar"),
                            Text(
                              '${viewModel.totalPrice.ceilToDouble()} TL',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            var payViewModel = Provider.of<PaymentViewModel>(
                                context,
                                listen: false);
                            payViewModel.pay(
                                _formKey.currentState!.validate(), context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shadowColor: Colors.black),
                          child: const Text(
                            'Ödeme Yap',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
