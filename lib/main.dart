import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/screens/spalsh_screen.dart';
import 'package:afer/translations/codegen_loader.g.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afer/SheredPreferance/sheredHelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await Firebase.initializeApp();
  await sherdprefrence.init();
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
 FirebaseInAppMessaging.instance;
  messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

 await messaging.requestPermission(

    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    if (message.notification != null) {
    }
  });
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translition',
          startLocale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          assetLoader: const CodegenLoader(),
          child:  const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {

   const MyApp({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(

      child: BlocProvider(
        create: (BuildContext context) =>
        AppCubit(),
        child:
           MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Afer',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              home:  const SplashScreen(),
            )
      ),
    );
  }


}

