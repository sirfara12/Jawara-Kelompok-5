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
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/penduduk_menu_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/warga/daftar_warga.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/daftar_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/tambah_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/detail_rumah.dart';
import 'package:jawara_pintar_kel_5/screens/admin/penduduk/rumah/edit_rumah.dart';
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
