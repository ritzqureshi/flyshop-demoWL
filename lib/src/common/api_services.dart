import 'package:dio/dio.dart';
import 'package:ikotech/src/common/utils/constant.dart';


class DioCommon {
  DioCommon._internal();
  static final DioCommon _instance = DioCommon._internal();
  factory DioCommon() => _instance;

  static final Dio _dio =
      Dio(
          BaseOptions(
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
            headers: {
              'X-Pass-Key': Constant.xPassKey,
              "Accept": "application/json",
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onError: (DioException e, ErrorInterceptorHandler handler) async {
              if (_shouldRetry(e)) {
                try {
                  await Future.delayed(const Duration(seconds: 2));
                  final response = await _dio.fetch(e.requestOptions);
                  return handler.resolve(response);
                } catch (err) {
                  return handler.next(e);
                }
              }
              return handler.next(e);
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            request: true,
            requestBody: true,
            responseBody: true,
            error: true,
            logPrint: (obj) => print('[DIO] $obj'),
          ),
        );

  String? _url;
  dynamic _payload;
  String _method = 'GET';

  set setUrl(String url) => _url = url;
  set setPayload(dynamic data) => _payload = data;
  set setMethod(String method) => _method = method.toUpperCase();

  /// Executes the request based on the set method
  Future<Response<dynamic>> get response async {
    if (_url == null) throw Exception("URL is not set");

    switch (_method) {
      case 'GET':
        return await _dio.get(_url!, queryParameters: _payload);
      case 'POST':
        return await _dio.post(_url!, data: _payload);
      case 'PUT':
        return await _dio.put(_url!, data: _payload);
      case 'DELETE':
        return await _dio.delete(_url!, data: _payload);
      default:
        throw Exception("Unsupported HTTP method: $_method");
    }
  }

  /// Retry logic for connection errors
  static bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.message!.contains('Connection reset by peer');
  }
}

// class DioCommon {
//   DioCommon._internal();
//   static final DioCommon _instance = DioCommon._internal();
//   factory DioCommon() => _instance;
//   static final Dio _dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(minutes: 5),
//       receiveTimeout: const Duration(minutes: 5),
//       headers: {'X-Pass-Key': Constant.xPassKey, "Accept": "application/json"},
//     ),
//   );

//   String? _url;
//   dynamic _payload;
//   String _method = 'GET';

//   set setUrl(String url) => _url = url;
//   set setPayload(dynamic data) => _payload = data;
//   set setMethod(String method) => _method = method.toUpperCase();

//   Future<Response<dynamic>> get response async {
//     if (_url == null) throw Exception("URL is not set");
//     if (_method == 'GET') {
//       return await _dio.get(_url!, data: (_payload));
//     } else {
//       return await _dio.post(_url!, data: (_payload));
//     }
//   }
// }
