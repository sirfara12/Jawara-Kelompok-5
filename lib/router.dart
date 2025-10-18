import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/dashboard.dart';
import 'package:jawara_pintar_kel_5/screens/layout.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/detail_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/tambah_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/edit_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/keuangan_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';
import 'package:jawara_pintar_kel_5/widget/custom_transition_page.dart';

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
              pageBuilder: (context, state) => customTransitionPage(
                key: state.pageKey,
                child: AdminDashboard(),
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/penduduk/daftar-warga',
              name: 'wargaList',
              pageBuilder: (context, state) => customTransitionPage(
                key: state.pageKey,
                child: const DaftarWargaPage(),
              ),
            ),
            GoRoute(
              path: '/admin/penduduk/detail-warga',
              name: 'wargaDetail',
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return customTransitionPage(
                  key: state.pageKey,
                  child: DetailWargaPage(warga: data),
                );
              },
            ),
            GoRoute(
              path: '/admin/penduduk/tambah-warga',
              name: 'wargaAdd',
              pageBuilder: (context, state) => customTransitionPage(
                key: state.pageKey,
                child: const TambahWargaPage(),
              ),
            ),
            GoRoute(
              path: '/admin/penduduk/edit-warga',
              name: 'wargaEdit',
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return customTransitionPage(
                  key: state.pageKey,
                  child: EditWargaPage(warga: data),
                );
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
