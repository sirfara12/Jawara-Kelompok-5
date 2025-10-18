import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/dashboard.dart';

import 'package:jawara_pintar_kel_5/screens/penduduk/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/detail_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/tambah_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/edit_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/keuangan_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';

final router = GoRouter(
  initialLocation: "/login",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => AdminDashboard(),
    ),
    GoRoute(
      path: '/penduduk/daftar',
      name: 'wargaList',
      builder: (context, state) => const DaftarWargaPage(),
    ),
    GoRoute(
      path: '/penduduk/detail',
      name: 'wargaDetail',
      builder: (context, state) {
        final data = state.extra as Map<String, String>? ?? {};
        return DetailWargaPage(warga: data);
      },
    ),
    GoRoute(
      path: '/penduduk/tambah',
      name: 'wargaAdd',
      builder: (context, state) => const TambahWargaPage(),
    ),
    GoRoute(
      path: '/penduduk/edit',
      name: 'wargaEdit',
      builder: (context, state) {
        final data = state.extra as Map<String, String>? ?? {};
        return EditWargaPage(warga: data);
      },
    ),
    GoRoute(
      path: '/admin/keuangan',
      builder: (context, state) => const KeuanganMenuScreen(),
    ),
    GoRoute(
      path: '/admin/pemasukan',
      builder: (context, state) => const PemasukanScreen(),
    ),
  ],
);
