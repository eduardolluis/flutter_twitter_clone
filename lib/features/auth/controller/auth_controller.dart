import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
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

    try {
      final res = await _authAPI.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      res.fold((l) => showSnackbar(context, l.message), (r) {
        // ignore: avoid_print
        print('User created: ${r.email}');
        showSnackbar(context, 'Account created successfully!');
      });
    } catch (e) {
      showSnackbar(context, 'Error: $e');
    } finally {
      state = false;
    }
  }

  void login({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    state = true;

    try {
      final res = await _authAPI.login(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      res.fold((l) => showSnackbar(context, l.message), (r) {
        // ignore: avoid_print
        print(r.userId);
      });
    } catch (e) {
      showSnackbar(context, 'Error: $e');
    } finally {
      state = false;
    }
  }
}
