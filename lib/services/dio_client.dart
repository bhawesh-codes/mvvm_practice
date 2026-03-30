import 'package:dio/dio.dart';
import 'package:mvvm_practice/services/secure_storage_service.dart';
import 'package:mvvm_practice/utils/const/api_url.dart';

class DioClient {
  final SecureStorageService _storage = SecureStorageService();

  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        // runs before every request
        onRequest: (options, handler) async {
          final token = await _storage.getToken();
          if (token != null) {
            options.headers['Authorization'] =
                'Token $token'; // ✅ auto attach token
          }
          return handler.next(options); // continue request
        },

        // runs on every successful response
        onResponse: (response, handler) {
          return handler.next(response); // continue normally
        },

        // runs on every error
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // token expired — you could logout user here
          }
          return handler.next(e); // continue error
        },
      ),
    );
  }
}
