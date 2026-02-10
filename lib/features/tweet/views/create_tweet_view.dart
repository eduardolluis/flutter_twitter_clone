import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetSCreen extends ConsumerStatefulWidget {
  static dynamic route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetSCreen());
  const CreateTweetSCreen({super.key});

  @override
  ConsumerState<CreateTweetSCreen> createState() => _CreateTweetSCreenState();
}

class _CreateTweetSCreenState extends ConsumerState<CreateTweetSCreen> {
  final tweetTextController = TextEditingController();

  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void shareTweet() {
    ref
        .read(tweetControllerProvider.notifier)
        .shareTweet(
          images: images,
          text: tweetTextController.text,
          context: context,
          repliedTo: '',
        );
    Navigator.pop(context);
  }

  void onPickImage() async {
    final res = await pickImages();

    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserDetailsProvider);

    final isLoading = ref.watch(tweetControllerProvider);

    return userAsync.when(
      loading: () => const Loader(),
      error: (err, st) => Scaffold(body: Center(child: Text(err.toString()))),
      data: (user) {
        if (user == null) return const Loader();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, size: 30),
            ),
            actions: [
              RoundedSmallButton(
                onTap: shareTweet,
                label: 'Tweet',
                backgroundColor: Pallete.blueColor,
                textColor: Pallete.whiteColor,
              ),
            ],
          ),
          body: isLoading
              ? const Loader()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.profilePic),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextField(
                                controller: tweetTextController,
                                style: const TextStyle(fontSize: 22),
                                decoration: const InputDecoration(
                                  hintText: 'What\'s happening?',
                                  hintStyle: TextStyle(
                                    color: Pallete.greyColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                        if (images.isNotEmpty)
                          CarouselSlider(
                            items: images.map((file) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Image.file(file),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 400,
                              enableInfiniteScroll: false,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Pallete.greyColor, width: 0.3),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ).copyWith(left: 15, right: 15),
                  child: GestureDetector(
                    onTap: onPickImage,
                    child: SvgPicture.asset(AssetsConstants.galleryIcon),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ).copyWith(left: 15, right: 15),
                  child: SvgPicture.asset(AssetsConstants.gifIcon),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ).copyWith(left: 15, right: 15),
                  child: SvgPicture.asset(AssetsConstants.emojiIcon),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
