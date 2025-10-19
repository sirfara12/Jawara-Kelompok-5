import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/dashboard.dart';
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/detail_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/tambah_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/edit_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/keuangan_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: "/login",
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AdminLayout(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/dashboard',
              builder: (context, state) => AdminDashboard(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/penduduk/daftar-warga',
              name: 'wargaList',
              builder: (context, state) => const DaftarWargaPage(),
            ),
            GoRoute(
              path: '/admin/penduduk/detail-warga',
              name: 'wargaDetail',
              builder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return DetailWargaPage(warga: data);
              },
            ),
            GoRoute(
              path: '/admin/penduduk/tambah-warga',
              name: 'wargaAdd',
              builder: (context, state) => const TambahWargaPage(),
            ),
            GoRoute(
              path: '/admin/penduduk/edit-warga',
              name: 'wargaEdit',
              builder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return EditWargaPage(warga: data);
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/keuangan',
              builder: (context, state) => const KeuanganMenuScreen(),
            ),
            GoRoute(
              path: '/admin/pemasukan',
              builder: (context, state) => const PemasukanScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
