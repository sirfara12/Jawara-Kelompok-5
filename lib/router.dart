import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/dashboard.dart';
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/penduduk_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/daftar_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/tambah_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/detail_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/edit_rumah.dart';
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
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => RegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AdminLayout(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/dashboard',
              name: 'admin_dashboard',
              builder: (context, state) => AdminDashboard(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/penduduk',
              name: 'pendudukMenu',
              builder: (context, state) => const PendudukMenuScreen(),
              routes: [
                GoRoute(
                  path: 'daftar-warga',
                  name: 'wargaList',
                  builder: (context, state) => const DaftarWargaPage(),
                ),
                GoRoute(
                  path: 'daftar-rumah',
                  name: 'rumahList',
                  builder: (context, state) => const DaftarRumahPage(),
                ),
                GoRoute(
                  path: 'tambah-rumah',
                  name: 'rumahAdd',
                  builder: (context, state) => const TambahRumahPage(),
                ),
                GoRoute(
                  path: 'detail-rumah',
                  name: 'rumahDetail',
                  builder: (context, state) {
                    final rumah = state.extra as Rumah;
                    return DetailRumahPage(rumah: rumah);
                  },
                ),
                GoRoute(
                  path: 'edit-rumah',
                  name: 'rumahEdit',
                  builder: (context, state) {
                    final rumah = state.extra as Rumah;
                    return EditRumahPage(rumah: rumah);
                  },
                ),
                GoRoute(
                  path: 'detail-warga',
                  name: 'wargaDetail',
                  builder: (context, state) {
                    final data = state.extra as Map<String, String>? ?? {};
                    return DetailWargaPage(warga: data);
                  },
                ),
                GoRoute(
                  path: 'tambah-warga',
                  name: 'wargaAdd',
                  builder: (context, state) => const TambahWargaPage(),
                ),
                GoRoute(
                  path: 'edit-warga',
                  name: 'wargaEdit',
                  builder: (context, state) {
                    final data = state.extra as Map<String, String>? ?? {};
                    return EditWargaPage(warga: data);
                  },
                ),
              ],
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
