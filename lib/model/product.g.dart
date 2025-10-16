// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  json['id'] as int?,
  json['images'] != null
      ? List<String>.from(json['images'] as List<dynamic>)
      : [],
  (json['price'] as num?)?.toDouble() ?? 0.0,
  json['brand'] as String? ?? 'Unknown',
  json['model'] as String? ?? '',
  json['category'] as String? ?? '',
  (json['discountPercentage'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.images,
      'price': instance.price,
      'brand': instance.brand,
      'model': instance.model,
      'category': instance.category,
      'discountPercentage': instance.discountPercentage,
    };
