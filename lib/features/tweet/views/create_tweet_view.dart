import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetSCreen extends ConsumerStatefulWidget {
  static dynamic route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetSCreen());
  const CreateTweetSCreen({super.key});

  @override
  ConsumerState<CreateTweetSCreen> createState() => _CreateTweetSCreenState();
}

class _CreateTweetSCreenState extends ConsumerState<CreateTweetSCreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserDetailsProvider);

    return userAsync.when(
      loading: () => const Loader(),
      error: (err, st) => Scaffold(body: Center(child: Text(err.toString()))),
      data: (user) {
        if (user == null) return const Loader();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, size: 30),
            ),
            actions: [
              RoundedSmallButton(
                onTap: () {},
                label: 'Tweet',
                backgroundColor: Pallete.blueColor,
                textColor: Pallete.whiteColor,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
