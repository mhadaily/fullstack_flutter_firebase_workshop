import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  // we must handle our message here!
  // for example to update UI or to do something in background silently
  print("Handling a background message: ${message.messageId}");
}
