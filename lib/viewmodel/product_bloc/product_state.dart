// import 'package:equatable/equatable.dart';
// import 'package:shophomework/model/product.dart';

// abstract class ProductState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<dynamic> products;
//   ProductLoaded(this.products);
// }

// class ProductError extends ProductState {
//   final String message;
//   ProductError(this.message);
// }

import 'package:equatable/equatable.dart';
import 'package:shophomework/model/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
