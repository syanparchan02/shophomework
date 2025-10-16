import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<String?> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      // print('Login Response: ${response.data}');

      if (response.statusCode == 200 && response.data['accessToken'] != null) {
        String token = response.data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return token;
      }
    } catch (e) {
      print("Login error: $e");
    }
    return null;
  }

  Future<List<dynamic>?> getProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception("No token found");

      final response = await dio.get(
        '/products',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('Product Response: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['products'];
      }
    } catch (e) {
      print("Product fetch error: $e");
    }
    return null;
  }
}
