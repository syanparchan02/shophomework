import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shophomework/repository/api_service.dart';
import 'package:shophomework/viewmodel/favorite_provider.dart';

import 'package:shophomework/viewmodel/product_bloc/product_bloc.dart';
import 'package:shophomework/viewmodel/product_bloc/product_even.dart';
import 'package:shophomework/viewmodel/product_bloc/product_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ApiService())..add(PLoadEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Searchscreen(),
      ),
    );
  }
}

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final Set<int> favoriteIndex = {};
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is ProductLoadedState) {
            final filteredList = state.plist
                .where(
                  (product) =>
                      (product.category ?? "").toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ) ||
                      (product.price
                              ?.toStringAsFixed(2)
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ??
                          false),
                )
                .toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Search products...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Found ${filteredList.length} items',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  if (filteredList.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final product = filteredList[index];
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
                                        image:
                                            product.image != null &&
                                                product.image!.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                  product.image!,
                                                ),
                                                fit: BoxFit.fitHeight,
                                                onError: (error, stackTrace) {
                                                  print(
                                                    "Image load failed: $error",
                                                  );
                                                },
                                              )
                                            : const DecorationImage(
                                                image: NetworkImage(
                                                  'https://th.bing.com/th/id/OIP.SH-RnT4VgSzVgv8ba6nZOAHaJ4?w=138&h=183&c=7&r=0&o=7&cb=12&dpr=1.5&pid=1.7&rm=3',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
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
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.7,
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
                                        product.category ?? "No Brand",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
