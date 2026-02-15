class AppwriteConstants {
  static const String databaseId = '6980a82a00092dc8554a';
  static const String projectId = '697e00fb003147c212a6';
  static const String projectName = "twitter_clone";
  static const String endpoint = 'https://nyc.cloud.appwrite.io/v1';

  static const String usersCollection = 'users';
  static const String tweetsCollection = 'tweets';
  static const String notificationsCollection = 'notifications';

  static const String imagesBucket = '6988f36900104b96baec';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
