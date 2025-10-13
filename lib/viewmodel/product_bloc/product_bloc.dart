import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophomework/repository/api_service.dart';
import 'package:shophomework/viewmodel/product_bloc/product_even.dart';
import 'package:shophomework/viewmodel/product_bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ApiService apiService = ApiService();

  ProductBloc(this.apiService) : super(ProdcutInitialState()) {
    on<PLoadEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        var pList = await apiService.getAllProducts();
        emit(ProductLoadedState(pList));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
