import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shophomework/screens/homescreen.dart';
import 'package:shophomework/screens/loginscreen.dart';
import 'package:shophomework/screens/searchscreen.dart';

final goRouterProvider = Provider<GoRouter>(
  create: (_) => GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) =>
            Homescreen(username: state.uri.queryParameters['username'] ?? ''),
      ),
      // GoRoute(
      //   path: '/search',
      //   builder: (context, state) => const Searchscreen(),
      // ),
    ],
  ),
);
