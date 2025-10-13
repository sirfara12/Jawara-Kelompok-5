import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';

final router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
  ],
);
