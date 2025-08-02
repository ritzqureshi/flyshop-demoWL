import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ikotech/src/data/bloc/homeScreenState/home_screen_cubit.dart';
import 'package:ikotech/src/data/bloc/loginState/login_state.dart';
import 'package:ikotech/src/data/provider/internet_state.dart';
import 'package:provider/provider.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'src/common/utils/constant.dart';
import 'src/common/utils/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(Constant.companyName);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
        ChangeNotifierProvider(
          create: (context) => InternetConnectivityState(),
        ),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetConnectivityState>(context).checkConnectivity(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        builder: BotToastInit(),
        title: Constant.companyName,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: _buildTheme(Brightness.light),
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(brightness: brightness);
    return baseTheme.copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.robotoFlexTextTheme(baseTheme.textTheme),
      primaryColor: Colors.lightBlueAccent,
    );
  }
}
