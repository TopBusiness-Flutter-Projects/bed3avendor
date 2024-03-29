import 'dart:async';
import 'dart:io';
import 'package:bed3avendor/provider/search_product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/app_localization.dart';
import 'package:bed3avendor/provider/auth_provider.dart';
import 'package:bed3avendor/provider/business_provider.dart';
import 'package:bed3avendor/provider/cart_provider.dart';
import 'package:bed3avendor/provider/chat_provider.dart';
import 'package:bed3avendor/provider/coupon_provider.dart';
import 'package:bed3avendor/provider/delivery_man_provider.dart';
import 'package:bed3avendor/provider/emergency_contact_provider.dart';
import 'package:bed3avendor/provider/language_provider.dart';
import 'package:bed3avendor/provider/localization_provider.dart';
import 'package:bed3avendor/provider/bottom_menu_provider.dart';
import 'package:bed3avendor/provider/order_provider.dart';
import 'package:bed3avendor/provider/product_provider.dart';
import 'package:bed3avendor/provider/product_review_provider.dart';
import 'package:bed3avendor/provider/profile_provider.dart';
import 'package:bed3avendor/provider/refund_provider.dart';
import 'package:bed3avendor/provider/shop_provider.dart';
import 'package:bed3avendor/provider/shipping_provider.dart';
import 'package:bed3avendor/provider/shop_info_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/provider/theme_provider.dart';
import 'package:bed3avendor/provider/bank_info_provider.dart';
import 'package:bed3avendor/provider/transaction_provider.dart';
import 'package:bed3avendor/theme/dark_theme.dart';
import 'package:bed3avendor/theme/light_theme.dart';
import 'package:bed3avendor/utill/app_constants.dart';
import 'package:bed3avendor/view/screens/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'di_container.dart' as di;
import 'notification/my_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  //////55
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await di.init();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int? _orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    _orderID = (notificationAppLaunchDetails!.payload != null &&
            notificationAppLaunchDetails.payload!.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload!)
        : null;
  }
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BankInfoProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BusinessProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TransactionProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductReviewProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShippingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DeliveryManProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RefundProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<BottomMenuController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<EmergencyContactProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
    ],
    child: MyApp(orderId: _orderID),
  ));
}

class MyApp extends StatelessWidget {
  final int? orderId;
  static final navigatorKey = new GlobalKey<NavigatorState>();

  const MyApp({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });
    return MaterialApp(
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: SplashScreen(orderId: orderId),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
