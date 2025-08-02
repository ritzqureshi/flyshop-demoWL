import 'dart:convert';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/utils/functions.dart';

import '../../common/api_services.dart';

class SplashSetting {
  static Future<dynamic> settingMethodApi() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.splashSettingApi;
      // dioCommon.setPayload = jsonEncode();
      final response = await dioCommon.response;
            // getLog(response, "responseData");

      if (response.statusCode == 200) {
        final jsonData = json.encode(response.data);
        return jsonData;
      } else {
        getLog(response.statusMessage, "settingMet");
      }
    } catch (e) {
      getLog(e.toString(), "Error settingMethodApi");
    }
  }
}
