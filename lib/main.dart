import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shophomework/viewmodel/favorite_provider.dart';
import 'package:shophomework/viewmodel/product_bloc/product_bloc.dart';
import 'package:shophomework/viewmodel/product_bloc/product_even.dart';
import 'repository/api_service.dart';
import 'viewmodel/user_bloc/user_bloc.dart';
import 'viewmodel/user_bloc/user_even.dart';
import 'router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(ApiService())..add(ULoadEvent()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ApiService())..add(PLoadEvent()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider()..loadFavorites(),
        ),
        goRouterProvider,
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = Provider.of<GoRouter>(context, listen: false);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
