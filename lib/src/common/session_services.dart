import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ikotech/src/data/model/LoginModel/user_model.dart';

import '../../main.dart';
import 'utils/constant.dart';

class SessionManager {
  static Future<void> saveUserDataLocally({
    UserModel? userModel,
    dynamic userCredential,
  }) async {
    final userBox = Hive.box(Constant.companyName);
    await userBox.put('loginTime', DateTime.now().toIso8601String());
    await userBox.put('usertype', userCredential['logintype']);
    await userBox.put('loginCredentials', {
      'email': userCredential['email'],
      'password': userCredential['password'],
    });
    await userBox.put('costumerData', userModel?.toJson());
  }

  static UserModel? getCostumereDataLocally() {
    final userBox = Hive.box(Constant.companyName);
    final userData = userBox.get('costumerData');
    if (userData == null) return null;
    final castedData = Map<String, dynamic>.from(userData);
    final userOnly = Map<String, dynamic>.from(castedData);
    return UserModel.fromJson(userOnly);
  }

  static void logout() async {
    final userBox = Hive.box(Constant.companyName);
    await userBox.delete('costumerData');
    await userBox.delete('loginTime');
    await userBox.delete('usertype');
    GoRouter.of(navigatorKey.currentState!.context).go('/welcomeScreen');
  }

  static Map<dynamic, dynamic>? getUserLoginCredential() {
    final userBox = Hive.box(Constant.companyName);
    final loginCredentials = userBox.get('loginCredentials');
    if (loginCredentials != null) {
      return loginCredentials;
    } else {
      return {'email': "", 'password': ""};
    }
  }

  static String getUsertype() {
    final userBox = Hive.box(Constant.companyName);
    final usertype = userBox.get('usertype');
    return usertype ?? "2";
  }

  static Future<bool> isLoginExpired() async {
    final userBox = Hive.box(Constant.companyName);
    final loginTimeStr = userBox.get('loginTime');
    if (loginTimeStr == null) return true; // Treat as expired if not present
    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) return true;
    final now = DateTime.now();
    return now.difference(loginTime).inHours >= 4;
  }
}
