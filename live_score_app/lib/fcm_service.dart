import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  static Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true
    );
    // Foreground - app already in view
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
    // Background - app is open, but not in view
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessage);
    // Terminated - app is fully close
    FirebaseMessaging.onBackgroundMessage(onBackgroundNotification);
  }

  static void _handleRemoteMessage(RemoteMessage message) {
    print(message.notification?.title);
    print(message.notification?.body);
    print(message.data);
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  static void listenTokenOnChange() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print(newToken);
      // Send to db
    });
  }
}

// Top level function
Future<void> onBackgroundNotification(RemoteMessage message) async {
    //TODO: whatever you want to do
}