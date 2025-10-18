import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/dashboard/dashboard.dart';
import 'package:jawara_pintar_kel_5/screens/layout.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/detail_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/tambah_warga.dart';
import 'package:jawara_pintar_kel_5/screens/penduduk/edit_warga.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';
import 'package:jawara_pintar_kel_5/widget/playstore_transition_page.dart';

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
              pageBuilder: (context, state) => playStoreTransitionPage(
                key: state.pageKey,
                child: AdminDashboard(),
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/penduduk/daftar',
              name: 'wargaList',
              pageBuilder: (context, state) => playStoreTransitionPage(
                key: state.pageKey,
                child: const DaftarWargaPage(),
              ),
            ),
            GoRoute(
              path: '/penduduk/detail',
              name: 'wargaDetail',
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return playStoreTransitionPage(
                  key: state.pageKey,
                  child: DetailWargaPage(warga: data),
                );
              },
            ),
            GoRoute(
              path: '/penduduk/tambah',
              name: 'wargaAdd',
              pageBuilder: (context, state) => playStoreTransitionPage(
                key: state.pageKey,
                child: const TambahWargaPage(),
              ),
            ),
            GoRoute(
              path: '/penduduk/edit',
              name: 'wargaEdit',
              pageBuilder: (context, state) {
                final data = state.extra as Map<String, String>? ?? {};
                return playStoreTransitionPage(
                  key: state.pageKey,
                  child: EditWargaPage(warga: data),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
