import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final userProfileControllerProvider = StateNotifierProvider((ref) {
  final tweetApi = ref.watch(tweetAPIProvider);
  return UserProfileController(tweetApi: tweetApi);
});

final getUserTweetsProvider = FutureProvider.family((ref, String uid) async {
  final userProfileController = ref.watch(
    userProfileControllerProvider.notifier,
  );
  return userProfileController.getUserTweets(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final TweetApi _tweetApi;
  UserProfileController({required TweetApi tweetApi})
    : _tweetApi = tweetApi,
      super(false);

  Future<List<Tweet>> getUserTweets(String uid) async {
    final tweets = await _tweetApi.getUserTweets(uid);
    return tweets.map((e) => Tweet.fromMap(e.data)).toList();
  }
}
