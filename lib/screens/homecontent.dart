import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shophomework/screens/promotion.dart';
import 'package:shophomework/viewmodel/favorite_provider.dart';
import 'package:shophomework/viewmodel/product_bloc/product_bloc.dart';
import 'package:shophomework/viewmodel/product_bloc/product_state.dart';

import 'package:shophomework/model/product.dart';

class HomeContent extends StatefulWidget {
  final String username;
  const HomeContent({super.key, required this.username});

  @override
  State<HomeContent> createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  final List<String> categories = const [
    "All",
    "Jewelery",
    "Electronics",
    "Women's Clothing",
    "Men's Clothing",
  ];
  String selectedCategory = "All";

  List<ProductModel> _getFilteredProducts(List<ProductModel> allProducts) {
    if (selectedCategory == "All") {
      return allProducts;
    }

    return allProducts
        .where(
          (product) =>
              product.category?.toLowerCase() == selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ProductLoadedState) {
          final List<ProductModel> filteredProducts = _getFilteredProducts(
            state.plist,
          );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hi, ${widget.username}'),
                  const SizedBox(height: 10),
                  const Text("Choose your favourite products"),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 50,
                    child: const TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color(0xFFE0E0E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          final bool isSelected = category == selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? Colors.pink
                                    : const Color(0xFFE0E0E0),
                                foregroundColor: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(category),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  AutoCarousel(),
                  const SizedBox(height: 10),
                  const Text('Recommended for you'),
                  const SizedBox(height: 20),

                  filteredProducts.isEmpty
                      ? const Center(
                          child: Text("No products found in this category."),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            final favoriteProvider =
                                Provider.of<FavoriteProvider>(context);
                            final isFavorite = favoriteProvider.isFavorite(
                              product,
                            );

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE0E0E0),
                                          image:
                                              (product.image != null &&
                                                  product.image!.isNotEmpty)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    product.image!,
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                )
                                              : null,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(10),
                                              ),
                                        ),
                                        child:
                                            (product.image == null ||
                                                product.image!.isEmpty)
                                            ? const Center(
                                                child: Text(
                                                  "No Image",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: InkWell(
                                          onTap: () {
                                            favoriteProvider.toggleFavorite(
                                              product,
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.5,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.pink,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.category ?? "No Category",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product.price != null
                                              ? "\$${product.price?.toStringAsFixed(2)}"
                                              : "No Price",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No products available.'));
        }
      },
    );
  }
}
