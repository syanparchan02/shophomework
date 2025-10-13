import 'package:equatable/equatable.dart';
import 'package:shophomework/model/product.dart';
import 'package:shophomework/model/user.dart';

abstract class ProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProdcutInitialState extends ProductState {
  ProdcutInitialState();
}

class ProductLoadingState extends ProductState {
  ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final List<ProductModel> plist;
  ProductLoadedState(this.plist);

  @override
  List<Object?> get props => [plist];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
