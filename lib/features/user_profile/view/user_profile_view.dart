import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
  import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/widget/user_profile.dart';
import 'package:twitter_clone/models/user_model.dart';

class UserProfileView extends ConsumerWidget {
  static dynamic route(UserModel userModel) => MaterialPageRoute(
    builder: (context) => UserProfileView(userModel: userModel),
  );

  final UserModel userModel;

  const UserProfileView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLiveAsync = ref.watch(
      getLatestUserProfileDataProvider(userModel.uid),
    );

    return Scaffold(
      body: userLiveAsync.when(
        data: (userLive) => UserProfile(user: userLive),
        error: (error, st) => ErrorText(error: error.toString()),
        loading: () => UserProfile(user: userModel),
      ),
    );
  }
}
