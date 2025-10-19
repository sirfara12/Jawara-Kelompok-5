import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/dashboard.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/keuangan_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/laporan_keuangan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/keuangan/pengeluaran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/laporan/cetak_laporan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/laporan/semua_pemasukan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/laporan/semua_pengeluaran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/detail_pemasukan_lain_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/kategori_iuran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_lain_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_lain_tambah_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/pemasukan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/tagih_iuran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/tagihan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/detail_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/edit_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/tambah_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pengeluaran/daftar_pengeluaran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pengeluaran/tambah_pengeluaran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/auth/login.dart';
import 'package:jawara_pintar_kel_5/screens/auth/register.dart';
import 'package:jawara_pintar_kel_5/screens/layout.dart';
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
    GoRoute(
      path: '/admin/pengeluaran',
      builder: (context, state) => const PengeluaranScreen(),
    ),
    GoRoute(
      path: '/admin/laporan-keuangan',
      builder: (context, state) => const LaporanKeuanganScreen(),
    ),
    // Pemasukan routes - halaman terpisah tanpa tab
    GoRoute(
      path: '/admin/pemasukan/kategori-iuran',
      builder: (context, state) => const KategoriIuranScreen(),
    ),
    GoRoute(
      path: '/admin/pemasukan/tagih-iuran',
      builder: (context, state) => const TagihIuranScreen(),
    ),
    GoRoute(
      path: '/admin/pemasukan/tagihan',
      builder: (context, state) => const TagihanScreen(),
    ),
    GoRoute(
      path: '/admin/pemasukan/pemasukan-lain',
      builder: (context, state) => const PemasukanLainScreen(),
    ),
    GoRoute(
      path: '/admin/pemasukan/pemasukan-lain-detail',
      builder: (context, state) {
        final data = state.extra as PemasukanLainModel;
        return DetailPemasukanLainScreen(data: data);
      },
    ),
    GoRoute(
      path: '/admin/pemasukan/pemasukan-lain-tambah',
      builder: (context, state) => const PemasukanLainTambahScreen(),
    ),
    // Pengeluaran routes
    GoRoute(
      path: '/admin/pengeluaran/daftar',
      builder: (context, state) => const DaftarPengeluaranScreen(),
    ),
    GoRoute(
      path: '/admin/pengeluaran/tambah',
      builder: (context, state) => const TambahPengeluaranScreen(),
    ),
    // Laporan routes
    GoRoute(
      path: '/admin/laporan/semua-pemasukan',
      builder: (context, state) => const SemuaPemasukanScreen(),
    ),
    GoRoute(
      path: '/admin/laporan/semua-pengeluaran',
      builder: (context, state) => const SemuaPengeluaranScreen(),
    ),
    GoRoute(
      path: '/admin/laporan/cetak-laporan',
      builder: (context, state) => const CetakLaporanScreen(),
    ),
  ],
);
