import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart' show Iconify;
import 'package:jawara_pintar_kel_5/constants/iconify.dart';
import 'package:jawara_pintar_kel_5/widget/bottom_app_bar_item.dart';
import 'package:moon_design/moon_design.dart';

class AdminLayout extends StatelessWidget {
  final Widget body;
  final int activeIndex;
  AdminLayout({super.key, required this.body, required this.activeIndex});

  final List<String> tabs = [
    'Rumah',
    'Penduduk',
    'Keuangan',
    'Kegiatan',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 72,
        padding: const EdgeInsets.only(bottom: 16),
        // shape: const CircularNotchedRectangle(),
        // notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomAppBarItem(
              icon: Icon(MoonIcons.generic_home_32_regular),
              label: tabs[0],
              active: activeIndex == 0,
              onTap: () => context.go('/admin/dashboard'),
            ),
            BottomAppBarItem(
              icon: Iconify(IconifyConstants.fluentPeopleLight, size: 24),
              label: tabs[1],
              active: activeIndex == 1,
              onTap: () {},
            ),
            BottomAppBarItem(
              icon: Iconify(IconifyConstants.letsIconMoneyLight, size: 24),
              label: tabs[2],
              active: activeIndex == 2,
              onTap: () {},
            ),
            BottomAppBarItem(
              icon: Iconify(IconifyConstants.arcticonActiviyManager, size: 24),
              label: tabs[3],
              active: activeIndex == 3,
              onTap: () {},
            ),
            BottomAppBarItem(
              icon: Iconify(IconifyConstants.fluentMoreHorizontalREG, size: 24),
              label: tabs[4],
              active: activeIndex == 4,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
