import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider<UserModel?>((ref) async {
  final account = await ref.watch(currentUserAccountProvider.future);
  if (account == null) return null;

  final doc = await ref.watch(userDetailsProvider(account.$id).future);
  return doc;
});

final userDetailsProvider = FutureProvider.family<UserModel, String>((
  ref,
  uid,
) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
    : _authAPI = authAPI,
      _userAPI = userAPI,
      super(false);

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

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

    res.fold((l) => showSnackbar(context, l.message), (r) async {
      UserModel userModel = UserModel(
        name: getNameFromEmail(email),
        email: email,
        followers: const [],
        following: const [],
        profilePic: '',
        bannerPic: '',
        uid: r.$id,
        bio: '',
        isTwitterBlue: false,
      );

      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackbar(context, l.message), (r) {
        showSnackbar(context, 'Account created! Please login');
        Navigator.push(context, LoginView.route());
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) {
      showSnackbar(context, 'Login successful!');
      Navigator.push(context, HomeView.route());
    });
  }

  /// ✅ ESTO ES LO QUE TE FALTABA
  void logout({required BuildContext context}) async {
    state = true;
    final res = await _authAPI.logout();
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) {
      // Evita que el user vuelva atrás al home con back
      Navigator.pushAndRemoveUntil(
        context,
        LoginView.route(),
        (route) => false,
      );
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
