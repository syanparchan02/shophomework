import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? image;
  final double? price;
  final String? brand;
  final String? model;
  final String? category;
  final int? discountPercentage;

  ProductModel(
    this.id,
    this.image,
    this.price,
    this.brand,
    this.model,
    this.category,
    this.discountPercentage,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
