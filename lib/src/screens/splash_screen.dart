import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/utils/functions.dart';
import 'package:ikotech/src/data/api/splash_setting_Api.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _localVersion = '';
  String _splashImageUrl = '';
  Color _backgroundColor = Colors.white;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    final stopwatch = Stopwatch()..start();

    await _getAppVersion();
    await _fetchSplashData();

    final elapsed = stopwatch.elapsed;
    const minDisplayTime = Duration(seconds: 2);

    if (elapsed < minDisplayTime) {
      await Future.delayed(minDisplayTime - elapsed);
    }

    _navigateToHome();
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _localVersion = packageInfo.version;
  }

  Future<void> _fetchSplashData() async {
    try {
      final response = await SplashSetting.settingMethodApi();
      final jsonData = jsonDecode(response);
      final data = jsonData['data'] ?? {};

      final logo = data['mobile_logo'] as String? ?? '';
      final nameComapny = data['display_company_name'] as String? ?? '';
      final bgColorHex = data['background_theme_color'] as String? ?? '#FFFFFF';
      final textColorHex = data['text_color'] as String? ?? '#000000';
      final homeBanner = data['mobile_banner'] as String? ?? '';

      // Set global constants
      Constant.companyLogo = logo;
      Constant.backgroundThemeColor = bgColorHex;
      Constant.textColour = textColorHex;
      Constant.companyName = nameComapny;
      // Constant.companyHomeBanner = homeBanner;

      setState(() {
        _splashImageUrl = logo;
        _backgroundColor = FunctionsUtils.hexToColor(bgColorHex);
        _dataLoaded = true;
      });
    } catch (e) {
      print('Splash data error: $e');
      // Fallback defaults
      Constant.companyLogo = '';
      Constant.backgroundThemeColor = '#FFFFFF';
      Constant.textColour = '#000000';

      setState(() {
        _splashImageUrl = '';
        _backgroundColor = Colors.white;
        _dataLoaded = true;
      });
    }
  }

  void _navigateToHome() {
    context.go('/welcomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: _dataLoaded
                ? FunctionsUtils.buildCachedImage(
                    _splashImageUrl,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.contain,
                  )
                : const CupertinoActivityIndicator(radius: 20),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Version $_localVersion',
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
