import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart' show Iconify;
import 'package:jawara_pintar_kel_5/constants/iconify.dart';
import 'package:jawara_pintar_kel_5/widget/bottom_app_bar_item.dart';
import 'package:moon_design/moon_design.dart';

class AdminLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  AdminLayout({super.key, required this.navigationShell});

  final Map<String, Widget> tabs = {
    'Rumah': Icon(MoonIcons.generic_home_32_regular),
    'Penduduk': Iconify(IconifyConstants.fluentPeopleLight, size: 24),
    'Keuangan': Iconify(IconifyConstants.letsIconMoneyLight, size: 24),
    'Kegiatan': Iconify(IconifyConstants.arcticonActiviyManager, size: 24),
    'Lainnya': Iconify(IconifyConstants.fluentMoreHorizontalREG, size: 24),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 72,
        padding: const EdgeInsets.only(bottom: 16),
        // shape: const CircularNotchedRectangle(),
        // notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            tabs.length,
            (index) => BottomAppBarItem(
              icon: tabs.values.elementAt(index),
              label: tabs.keys.elementAt(index),
              active: navigationShell.currentIndex == index,
              onTap: () => _goTo(context, index),
            ),
          ).toList(),
        ),
      ),
    );
  }

  void _goTo(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
