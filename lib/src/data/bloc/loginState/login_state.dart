import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikotech/src/common/utils/functions.dart';
import 'package:ikotech/src/data/model/LoginModel/user_model.dart';

import '../../../../main.dart';
import '../../../common/session_services.dart';
import '../../../common/utils/colours.dart';
import '../../../common/widgets/otp_verify_wid.dart';
import '../../api/login_auth_api.dart';

class LoginState with ChangeNotifier {
  // final _userBox = Hive.box(Constant.companyName);
  bool _isLoading = false;
  String? _message = '';
  UserModel? _userModel;
  bool _isLoggedIn = false;

  UserModel get userModel => _userModel!;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get message => _message!;

  Future<void> loginAndVerify(BuildContext context, dynamic request) async {
    try {
      FunctionsUtils.loadingDialog(navigatorKey.currentState!.context);
      final response = await LoginAuthApi.loginAndVerifyOTPApi(request);
      getLog(response, "loginAndVerify");
      _message = response['message'];
      if (response['status']) {
        navigatorKey.currentState!.pop();
        FunctionsUtils.toastSuccessNotification(_message.toString());
        _isLoggedIn = true;
        _isLoading = true;

        _userModel = UserModel.fromJson(response);
        await SessionManager.saveUserDataLocally(
          userModel: _userModel!,
          userCredential: request,
        );
        navigatorKey.currentState!.context.go('/homescreen');
        notifyListeners();
      } else {
        navigatorKey.currentState!.pop();
        FunctionsUtils.toastFailedNotification(_message.toString());
      }
    } catch (e) {
      _message = 'An error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginSendOtp(BuildContext context, dynamic request) async {
    try {
      FunctionsUtils.loadingDialog(navigatorKey.currentState!.context);
      final response = await LoginAuthApi.loginAndSendOTPApi(request);
      getLog(response.runtimeType, "response12s");
      getLog(request, "response12s");
      _message = response['message'];
      if (response['status']) {
        navigatorKey.currentState!.pop();
        FunctionsUtils.toastSuccessNotification(_message.toString());
        _isLoggedIn = true;
        _isLoading = true;
        Future.delayed(Duration(seconds: 1), () async {
          _showotpVerifySheet(context, request);
        });
        notifyListeners();
      } else {
        navigatorKey.currentState!.pop();
        FunctionsUtils.toastFailedNotification(_message.toString());
      }
    } catch (e) {
      _message = 'An error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> _showotpVerifySheet(
    BuildContext context,
    dynamic request,
  ) async {
    final result = await showModalBottomSheet(
      backgroundColor: MyColors.white,
      context: context,
      isDismissible: false,
        isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: OtpVerifyWid(
            title: "",
            number: request['mobile'],
            request: request,
          ),
        );
      },
    );
    return result;
  }
}
