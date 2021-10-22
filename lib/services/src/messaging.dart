import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mjcoffee/widgets/widgets.dart';

class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Singleton setup: prevents multiple instances of this class.
  MessagingService._();
  static final MessagingService _service = MessagingService._();
  factory MessagingService() => _service;

  static MessagingService get instance => _service;

  Future<void> initialize() async {
    final NotificationSettings settings = await _requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _getToken();
      _firebaseMessagingForgroundHandler();
    }
  }

  Future<void> subscribeToTopic(String topic) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<bool> isPremissionEnabled(AuthorizationStatus status) async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == status;
  }

  Future<NotificationSettings> _requestPermission() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      announcement: false,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    return settings;
  }

  _firebaseMessagingForgroundHandler() {
    FirebaseMessaging.onMessage.listen(
      (
        RemoteMessage message,
      ) {
        print('Message data: ${message.data}');
        // custom message data: {price: 10, coffee: latte2}
        if (message.notification != null) {
          showAlertDialog(
            message.notification!.body ?? '',
            message.notification?.title,
          );
        }
      },
    );
  }

  void showMessage(RemoteMessage remoteMessage) {
    showAlertDialog(remoteMessage.messageId ?? '');
  }

  get userDeviceToken {
    return _token;
  }

  String? _token;

  void setToken(String token) {
    print('FCM Token: $token');
    _token = token;
  }

  Future<void> _getToken() async {
    final String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      _token = token;
    }

    _firebaseMessaging.onTokenRefresh.listen(setToken);
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
  }
}
