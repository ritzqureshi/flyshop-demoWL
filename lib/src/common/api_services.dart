import 'package:dio/dio.dart';
import 'package:ikotech/src/common/utils/constant.dart';

class DioCommon {
  DioCommon._internal();
  static final DioCommon _instance = DioCommon._internal();
  factory DioCommon() => _instance;
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
      headers: {'X-Pass-Key': Constant.xPassKey, "Accept": "application/json"},
    ),
  );
  String? _url;
  dynamic _payload;
  String _method = 'GET';

  set setUrl(String url) => _url = url;
  set setPayload(dynamic data) => _payload = data;
  set setMethod(String method) => _method = method.toUpperCase();

  Future<Response<dynamic>> get response async {
    if (_url == null) throw Exception("URL is not set");
    if (_method == 'GET') {
      return await _dio.get(_url!, data: (_payload));
    } else {
      return await _dio.post(_url!, data: (_payload));
    }
  }
}
