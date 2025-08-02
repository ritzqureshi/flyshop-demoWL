import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikotech/src/common/widgets/drawer_item_wid.dart';

import '../../../main.dart';
import '../../data/model/customItemModel/custom_item_model.dart';
import '../../screens/home_screen_b2b.dart';
import '../../screens/login_screen.dart';
import '../../screens/main_screen.dart';
import '../../screens/splash_screen.dart';
import '../../screens/welcome_content.dart';

class AppRouter {
  static final _router = GoRouter(
    observers: <NavigatorObserver>[BotToastNavigatorObserver()],
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(
        path: '/welcomeScreen',
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(path: '/LoginScreen', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/homescreen',
        builder: (context, state) => HomeScreenB2b(),
      ),
      GoRoute(path: '/mainScreen', builder: (context, state) => MainScreen()),
      GoRoute(
        path: '/drawerItemPage',
        builder: (context, state) =>
            CmsPageScreen(itemData: state.extra as CustomDrawerItemModel),
      ),
    ],
  );

  static GoRouter get router => _router;
}
