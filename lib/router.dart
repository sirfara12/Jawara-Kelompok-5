import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => LoginScreen())],
);
