import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart' show Iconify;
import 'package:jawara_pintar_kel_5/constants/iconify.dart';
import 'package:jawara_pintar_kel_5/widget/bottom_app_bar_item.dart';
import 'package:moon_design/moon_design.dart';

class AdminLayout extends StatelessWidget {
  final Widget body;
  final int activeIndex;
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? appBarActions;
  final bool showBottomNav;

  AdminLayout({
    super.key,
    required this.body,
    required this.activeIndex,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.appBarActions,
    this.showBottomNav = true,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  bool _isAnimating = false;

  final Map<String, Widget> tabs = {
    'Rumah': Icon(MoonIcons.generic_home_32_regular),
    'Penduduk': Iconify(IconifyConstants.fluentPeopleLight, size: 24),
    'Keuangan': Iconify(IconifyConstants.letsIconMoneyLight, size: 24),
    'Kegiatan': Iconify(IconifyConstants.arcticonActiviyManager, size: 24),
    'Lainnya': Iconify(IconifyConstants.fluentMoreHorizontalREG, size: 24),
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _fade = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.easeOutSine,
      reverseCurve: Curves.easeInSine,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: showBackButton
                  ? IconButton(
                      onPressed: onBackPressed ?? () => context.pop(),
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                    )
                  : null,
              title: Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: appBarActions,
            )
          : null,
      body: SafeArea(child: body),
      bottomNavigationBar: showBottomNav
          ? BottomAppBar(
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
                    onTap: () => context.go('/admin/penduduk/daftar-warga'),
                  ),
                  BottomAppBarItem(
                    icon: Iconify(
                      IconifyConstants.letsIconMoneyLight,
                      size: 24,
                    ),
                    label: tabs[2],
                    active: activeIndex == 2,
                    onTap: () => context.go('/admin/keuangan'),
                  ),
                  BottomAppBarItem(
                    icon: Iconify(
                      IconifyConstants.arcticonActiviyManager,
                      size: 24,
                    ),
                    label: tabs[3],
                    active: activeIndex == 3,
                    onTap: () {},
                  ),
                  BottomAppBarItem(
                    icon: Iconify(
                      IconifyConstants.fluentMoreHorizontalREG,
                      size: 24,
                    ),
                    label: tabs[4],
                    active: activeIndex == 4,
                    onTap: () {},
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Future<void> _goTo(int index) async {
    // Reset the current branch if tapping the active tab.
    final isReselect = index == widget.navigationShell.currentIndex;
    if (_isAnimating && !isReselect) return; // avoid overlapping animations

    if (isReselect) {
      widget.navigationShell.goBranch(index, initialLocation: true);
      return;
    }

    try {
      _isAnimating = true;
      // Fade out current content
      await _controller.forward();
      if (!mounted) return;

      // Switch branch while content is invisible
      widget.navigationShell.goBranch(index, initialLocation: false);

      // Give a frame for the new content to layout before fade-in
      await Future.delayed(const Duration(milliseconds: 16));
    } finally {
      if (mounted) {
        await _controller.reverse(); // Fade in new content
      }
      _isAnimating = false;
    }
  }
}
