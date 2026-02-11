import 'package:dio/dio.dart';

import '../../api/api_constants.dart';


class MyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "x-api-key":ApiConstants.apiKey
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Custom Response: ${response.statusCode}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("Custom Error: ${err.message}");
    handler.next(err);
  }
}