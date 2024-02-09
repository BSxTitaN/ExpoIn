import 'package:expoin/Pages/onboarding/ui/onboarding.dart';
import 'package:expoin/Utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'Design-System/colors.dart';
import 'Pages/home/ui/home.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      name: 'CiPass', options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  await FirebaseAppCheck.instance.activate(
    androidProvider:
    kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  if (FirebaseAuth.instance.currentUser != null) {
    await analytics.setUserId(id: FirebaseAuth.instance.currentUser?.uid);
  }

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    FirebaseCrashlytics.instance
        .setUserIdentifier(FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : "Logged-Out User/Unknown");
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Signing hash of your app
  // String base64Hash = hashConverter.fromSha256toBase64(
  //     "B5:A8:9E:20:C3:C6:89:30:71:C6:79:51:5C:4E:B1:16:28:F0:B0:B1:9A:07:06:AF:1F:14:00:7A:5C:62:C6:B7");
  //
  // // create configuration for freeRASP
  // final config = TalsecConfig(
  //   /// For Android
  //   androidConfig: AndroidConfig(
  //     packageName: 'com.harshparekh.expoin',
  //     signingCertHashes: [
  //       base64Hash,
  //     ],
  //     supportedStores: [],
  //   ),
  //
  //   /// For iOS
  //   iosConfig: IOSConfig(
  //     bundleIds: ['YOUR_APP_BUNDLE_ID'],
  //     teamId: 'M8AK35...',
  //   ),
  //
  //   watcherMail: 'hsp22903@gmail.com',
  //   isProd: kDebugMode ? false : true,
  // );
  //
  // // Setting up callbacks
  // final deviceInfo = await getDeviceInfo();
  //
  // String model = '';
  // if (deviceInfo != null) {
  //   // Determine the appropriate device information based on platform
  //   if (deviceInfo is AndroidDeviceInfo) {
  //     model = deviceInfo.model;
  //   } else if (deviceInfo is IosDeviceInfo) {
  //     model = deviceInfo.utsname.machine;
  //   } else if (deviceInfo is WebBrowserInfo) {
  //     model = deviceInfo.userAgent!;
  //   }
  // }
  //
  // // Threat callback with logging
  // final user = FirebaseAuth.instance.currentUser;
  // String userId = user?.uid ?? DateTime.now().toString();
  //
  // final callback = ThreatCallback(
  //   onAppIntegrity: () async {
  //     await FirebaseCrashlytics.instance.log(
  //         "App-Integrity Error detected! Bailing out $userId. Device model: $model");
  //   },
  //   onObfuscationIssues: () {
  //     FirebaseCrashlytics.instance
  //         .log("Obfuscation issues $userId. Device model: $model");
  //     exit(0);
  //   },
  //   onDebug: () {
  //     FirebaseCrashlytics.instance
  //         .log("Debugging $userId. Device model: $model");
  //   },
  //   onDeviceBinding: () {
  //     FirebaseCrashlytics.instance
  //         .log("Device binding $userId. Device model: $model");
  //   },
  //   onDeviceID: () {
  //     FirebaseCrashlytics.instance
  //         .log("Device ID $userId. Device model: $model");
  //   },
  //   onHooks: () {
  //     FirebaseCrashlytics.instance.log("Hooks $userId. Device model: $model");
  //   },
  //   onPasscode: () {
  //     FirebaseCrashlytics.instance
  //         .log("Passcode not set $userId. Device model: $model");
  //   },
  //   onPrivilegedAccess: () {
  //     FirebaseCrashlytics.instance
  //         .log("Privileged access $userId. Device model: $model");
  //   },
  //   onSecureHardwareNotAvailable: () {
  //     FirebaseCrashlytics.instance
  //         .log("Secure hardware not available $userId. Device model: $model");
  //   },
  //   onSimulator: () {
  //     FirebaseCrashlytics.instance
  //         .log("Simulator $userId. Device model: $model");
  //   },
  //   onUnofficialStore: () {
  //     FirebaseCrashlytics.instance
  //         .log("Unofficial store $userId. Device model: $model");
  //   },
  // );
  //
  // // Attaching listener
  // Talsec.instance.attachListener(callback);
  //
  // // start freeRASP
  // await Talsec.instance.start(config);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  auth() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const Home();
    } else {
      return const Onboarding();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomAuthProvider()),
      ],
      child: MaterialApp(
        title: 'ExpoIn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Geist",
          colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.mainAppColor),
          useMaterial3: true,
        ),
        home: auth(),
      ),
    );
  }
}
