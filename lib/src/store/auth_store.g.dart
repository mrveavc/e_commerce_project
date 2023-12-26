// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$currentUSerAtom =
      Atom(name: '_AuthStore.currentUSer', context: context);

  @override
  User? get currentUSer {
    _$currentUSerAtom.reportRead();
    return super.currentUSer;
  }

  @override
  set currentUSer(User? value) {
    _$currentUSerAtom.reportWrite(value, super.currentUSer, () {
      super.currentUSer = value;
    });
  }

  late final _$isUserLoggedInAtom =
      Atom(name: '_AuthStore.isUserLoggedIn', context: context);

  @override
  bool get isUserLoggedIn {
    _$isUserLoggedInAtom.reportRead();
    return super.isUserLoggedIn;
  }

  @override
  set isUserLoggedIn(bool value) {
    _$isUserLoggedInAtom.reportWrite(value, super.isUserLoggedIn, () {
      super.isUserLoggedIn = value;
    });
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void setCurrentUser(User? cUser, bool isLoggedIn) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setCurrentUser');
    try {
      return super.setCurrentUser(cUser, isLoggedIn);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUSer: ${currentUSer},
isUserLoggedIn: ${isUserLoggedIn}
    ''';
  }
}
