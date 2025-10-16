// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shophomework/repository/api_service.dart';
// import 'package:shophomework/viewmodel/product_bloc/product_even.dart';

// import 'product_state.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ApiService apiService;

//   ProductBloc(this.apiService) : super(ProductInitial()) {
//     on<LoadProducts>((event, emit) async {
//       emit(ProductLoading());
//       final products = await apiService.getProducts();

//       if (products != null) {
//         emit(ProductLoaded(products));
//       } else {
//         emit(ProductError("Failed to load products"));
//       }
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophomework/model/product.dart';
import 'package:shophomework/repository/api_service.dart';
import 'package:shophomework/viewmodel/product_bloc/product_even.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());

      final productsJson = await apiService.getProducts();

      if (productsJson != null) {
        // ✅ Convert List<dynamic> → List<ProductModel>
        final products = productsJson
            .map((item) => ProductModel.fromJson(item))
            .toList();

        emit(ProductLoaded(products));
      } else {
        emit(ProductError("Failed to load products"));
      }
    });
  }
}
