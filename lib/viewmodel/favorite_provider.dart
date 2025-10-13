import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product.dart';

class FavoriteProvider with ChangeNotifier {
  List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  static const String _favoritesKey = 'favorite_products_key';

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);

    if (favoritesJson != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(favoritesJson);
        _favorites = jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print('Error loading favorites: $e');
        }
      }
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final String favoritesJson = jsonEncode(
      _favorites.map((p) => p.toJson()).toList(),
    );
    await prefs.setString(_favoritesKey, favoritesJson);
  }

  bool isFavorite(ProductModel product) {
    return _favorites.any((fav) => fav.id == product.id);
  }

  void toggleFavorite(ProductModel product) {
    final isCurrentlyFavorite = isFavorite(product);

    if (isCurrentlyFavorite) {
      _favorites.removeWhere((fav) => fav.id == product.id);
    } else {
      _favorites.add(product);
    }

    notifyListeners();
    _saveFavorites();
  }
}
