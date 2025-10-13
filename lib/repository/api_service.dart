// import 'package:dio/dio.dart';
// import 'package:shophomework/model/product.dart';
// import 'package:shophomework/model/user.dart';

// class ApiService {
//   final String userurl = 'https://fakestoreapi.com/users';
//   final String producturl = 'https://fakestoreapi.in/api/products';

//   Dio dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://fakestoreapi.com/',
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

//   Future<List<UserModel>> getUsers() async {
//     try {
//       final response = await dio.get(userurl);

//       final udataList = response.data as List;

//       return udataList.map((e) => UserModel.fromJson(e)).toList();
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timed out. Please check your internet.');
//       } else {
//         throw Exception('Failed to fetch users: ${e.message}');
//       }
//     }
//   }

//   // Future<List<ProductModel>> getAllProducts() async {
//   //   try {
//   //     final response = await dio.get(producturl);

//   //     final pdataList = response.data as List;

//   //     return pdataList.map((e) => ProductModel.fromJson(e)).toList();
//   //   } on DioException catch (e) {
//   //     if (e.type == DioExceptionType.connectionTimeout) {
//   //       throw Exception('Connection timed out. Please check your internet.');
//   //     } else {
//   //       throw Exception('Failed to fetch product: ${e.message}');
//   //     }
//   //   }
//   // }
//   Future<List<ProductModel>> getAllProducts() async {
//     try {
//       final response = await dio.get("https://fakestoreapi.in/api/products");

//       final data = response.data;

//       // If the API returns { "products": [...] }
//       final pdataList = data['products'] as List;

//       return pdataList.map((e) => ProductModel.fromJson(e)).toList();
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timed out. Please check your internet.');
//       } else {
//         throw Exception('Failed to fetch product: ${e.message}');
//       }
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:shophomework/model/product.dart';
import 'package:shophomework/model/user.dart';

class ApiService {
  final String userRoute = 'users';
  final String productRoute = 'products';

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dio.get(userRoute);
      final udataList = response.data as List;
      return udataList.map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timed out. Please check your internet.');
      } else {
        throw Exception('Failed to fetch users: ${e.message}');
      }
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get(productRoute);

      // fakestoreapi.com returns a List directly
      final pdataList = response.data as List;

      return pdataList.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timed out. Please check your internet.');
      } else {
        throw Exception('Failed to fetch product: ${e.message}');
      }
    }
  }

  // Future<List<ProductModel>> getAllProducts() async {
  //   try {
  //     final response = await dio.get(producturl);

  //     final data = response.data;

  //     if (data is List) {
  //       return data.map((e) => ProductModel.fromJson(e)).toList();
  //     } else if (data is Map && data['products'] is List) {
  //       return (data['products'] as List)
  //           .map((e) => ProductModel.fromJson(e))
  //           .toList();
  //     } else {
  //       throw Exception('Unexpected API response format');
  //     }
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout) {
  //       throw Exception('Connection timed out. Please check your internet.');
  //     } else {
  //       throw Exception('Failed to fetch product: ${e.message}');
  //     }
  //   }
  // }
}
