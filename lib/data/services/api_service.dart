import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? params}) async {    //To perform a GET request to an API endpoint and return the response as a Map<String, dynamic>.
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}