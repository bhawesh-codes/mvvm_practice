import 'package:dio/dio.dart';
import 'package:mvvm_practice/services/dio_client.dart';
import 'package:mvvm_practice/view/home/models/book_model.dart';

class ApiService {
  final Dio _dio = DioClient().dio; // ✅ use dio client with interceptor
  int page = 1;

  Future<BookModel?> fetchBooks() async {
    try {
      final response = await _dio.get(
        '/books/new-releases/',
        queryParameters: {'page': page}, // ✅ cleaner than string interpolation
      );
      return BookModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Failed to fetch books");
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/login/',
        data: {"username": username, "password": password},
      );
      return response.data['token'];
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Check your credentials");
    }
  }
}
