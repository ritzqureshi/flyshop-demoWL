import 'dart:convert';
import 'package:ikotech/src/common/utils/constant.dart';
import 'package:ikotech/src/common/utils/functions.dart';

import '../../common/api_services.dart';

class WelcomeContentApi {
  static Future<dynamic> welcomeMethodApi() async {
    try {
      final dioCommon = DioCommon();
      dioCommon.setUrl = Constant.welcomContentApi;
      // dioCommon.setPayload = jsonEncode();
      final response = await dioCommon.response;
      if (response.statusCode == 200) {
        final jsonData = json.encode(response.data);
        return jsonData;
      } else {
        getLog(response.statusMessage, "WelcomeContentApi");
      }
    } catch (e) {
      getLog(e.toString(), "Error WelcomeContentApi");
    }
  }
}
