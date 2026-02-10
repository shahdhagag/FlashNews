import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        "x-api-key": ApiConstants.apiKey,

      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
}
