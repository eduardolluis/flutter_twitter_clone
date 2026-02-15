import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/notification_api.dart';
import 'package:twitter_clone/core/enums/notification_type_enum.dart';
import 'package:twitter_clone/models/notification_model.dart';

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, bool>((ref) {
      return NotificationController(
        notificationApi: ref.watch(notificationAPIProvider),
      );
    });

class NotificationController extends StateNotifier<bool> {
  final NotificationApi _notificationApi;
  NotificationController({required NotificationApi notificationApi})
    : _notificationApi = notificationApi,
      super(false);

  void createNotification({
    required String text,
    required String postId,
    required String uid,
    required NotificationType notificationType,
  }) async {
    final notification = Notification(
      text: text,
      postId: postId,
      id: '',
      uid: uid,
      notificationType: notificationType,
    );
    final res = await _notificationApi.createNotification(notification);
    res.fold((l) => print(l.message), (r) => null);
  }
}
