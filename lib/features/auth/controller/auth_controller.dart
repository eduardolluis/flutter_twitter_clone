import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, bool>((ref) {
      return AuthController(authAPI: ref.watch(authAPIProvider));
    });

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI}) : _authAPI = authAPI, super(false);

  void signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) => print(r.email));
  }
}
