// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class InAppMessagingService {
  final _firebaseInAppMessaging = FirebaseInAppMessaging.instance;

  // Singleton setup: prevents multiple instances of this class.
  InAppMessagingService._();
  static final InAppMessagingService _service = InAppMessagingService._();
  factory InAppMessagingService() => _service;

  static InAppMessagingService get instance => _service;

  // triger an Analytics events
  triggerEvent(String event) {
    _firebaseInAppMessaging.triggerEvent(event);
  }

  /// Enables or disables suppression of message displays.
  Future<void> setMessagesSuppressed(bool suppress) async {
    return _firebaseInAppMessaging.setMessagesSuppressed(suppress);
  }
}
