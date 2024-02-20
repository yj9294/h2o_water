
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/screens/home_screen.dart';
import 'package:h2o_keeper/src/screens/loading_screen.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:h2o_keeper/src/utils/notification_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationUtil().register();
  await AppTrackingTransparency.requestTrackingAuthorization();
  Permission.appTrackingTransparency;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoadingLogic()),
    ChangeNotifierProvider(create: (context) => HomeLogic()),
    ChangeNotifierProvider(create: (context) => ChartsLogic()),
    ChangeNotifierProvider(create: (context) => MedalLogic()),
    ChangeNotifierProvider(create: (context) => ProfileLogic())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeLogic = context.watch<HomeLogic>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        theme: ThemeData.light(),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: homeLogic.local,
        home: const ContentScreen());
  }
}

class ContentScreen extends StatefulWidget {
    const ContentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingLogic = context.watch<LoadingLogic>();
    return loadingLogic.isLoading
        ? const LoadingScreen()
        : const HomeScreen();
  }
}