import '../../common/api_services.dart';
import '../../common/utils/constant.dart';
import '../../common/utils/functions.dart';

class LoginAuthApi {
  static Future<dynamic> loginAndSendOTPApi(dynamic request) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl =
          "${Constant.loginAuthSendOtpApi}&mobile=${request['mobile']}&country_code=${request['country_code']}";
      dioCommon.setMethod = "POST";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final jsonData = (response.data);
        return jsonData;
      } else {
        getLog(response.statusMessage, "settingMet");
      }
    } catch (e) {
      getLog(e.toString(), "Error loginAndSendOTPApi");
    }
  }

  static Future<dynamic> loginAndVerifyOTPApi(dynamic request) async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl =
          "${Constant.loginAuthVerifyOtpApi}&mobile=${request['mobile']}&loginOtp=${request['otp']}";
      dioCommon.setMethod = "POST";
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final jsonData = (response.data);
        return jsonData;
      } else {
        getLog(response.statusMessage, "settingMet");
      }
    } catch (e) {
      getLog(e.toString(), "Error loginAndVerifyOTPApi");
    }
  }
}
