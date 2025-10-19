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

import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/daftar_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/tambah_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/edit_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/detail_kegiatan_screen.dart';

import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/broadcast/daftar_broadcast.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/broadcast/tambah_broadcast.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/broadcast/detail_broadcast_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/broadcast/edit_broadcast_screen.dart';

import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/pesanwarga/pesanwarga_tab.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/pesanwarga/edit_pesan_warga_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/pesanwarga/detail_pesan_warga_screen.dart';


import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/logaktivitas/logaktivitas_tab.dart';

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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/admin/kegiatan',
              name: 'kegiatanMenu',
              builder: (context, state) => const KegiatanScreen(),
              routes: [
                GoRoute(
                  path: 'daftar',
                  builder: (context, state) => const DaftarKegiatanScreen(),
                ),
                GoRoute(
                  path: 'tambah',
                  builder: (context, state) => const TambahKegiatanScreen(),
                ),
                GoRoute(
                  path: 'detail',
                  builder: (context, state) {
                    final kegiatanData = state.extra as Map<String, String>? ?? {};
                    return DetailKegiatanScreen(kegiatan: kegiatanData);
                  },
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final kegiatanData = state.extra as Map<String, String>? ?? {};
                    return EditKegiatanScreen(kegiatan: kegiatanData);
                  },
                ),
                GoRoute(
                  path: 'broadcast/daftar',
                  name: 'broadcastDaftar',
                  builder: (context, state) => const DaftarBroadcastScreen(),
                ),
                GoRoute(
                  path: 'broadcast/tambah',
                  name: 'broadcastTambah',
                  builder: (context, state) => const TambahBroadcastScreen(),
                ),
                GoRoute(
                  path: 'broadcast/detail/:judul',
                  name: 'broadcastDetail',
                  builder: (context, state) {
                    final _ = state.pathParameters['judul']!;
                    final broadcastData = state.extra as KegiatanBroadcast?;
                    if (broadcastData == null) return const DaftarBroadcastScreen();
                    return DetailBroadcastScreen(broadcastData: broadcastData);
                  },
                ),
                GoRoute(
                  path: 'broadcast/edit/:judul',
                  name: 'broadcastEdit',
                  builder: (context, state) {
                    final _ = state.pathParameters['judul']!;
                    final broadcastData = state.extra as Map<String, dynamic>?;
                    if (broadcastData == null || broadcastData['data'] == null) {
                      return const DaftarBroadcastScreen();
                    }
                    return EditBroadcastScreen(
                      initialBroadcastData: broadcastData['data'] as KegiatanBroadcast,
                    );
                  },
                ),
               GoRoute(
                  path: 'pesanwarga',
                  name: 'pesanWarga',
                  builder: (context, state) => const PesanWargaScreen(),
                ),
                GoRoute(
                  path: 'logaktivitas',
                  name: 'logAktivitas',
                  builder: (context, state) => const LogAktivitasScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
                