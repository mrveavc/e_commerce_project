import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

@singleton
class AuthStore extends _AuthStore with _$AuthStore {}

abstract class _AuthStore with Store {
  @observable
  User? currentUSer;

  @observable
  bool isUserLoggedIn = false;

  @action
  void setCurrentUser(User? cUser, bool isLoggedIn) {
    if (cUser != null) {
      currentUSer = cUser;
      isUserLoggedIn = isLoggedIn;
    } else {
      currentUSer = null;
    }
  }
}
