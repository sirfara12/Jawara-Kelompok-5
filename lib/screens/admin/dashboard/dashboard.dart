import 'package:flutter/material.dart';
import 'package:jawara_pintar_kel_5/providers/admin_dashboard_provider.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/kegiatan.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/kependudukan.dart';
import 'package:jawara_pintar_kel_5/screens/admin/dashboard/keuangan.dart';
import 'package:moon_design/moon_design.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _previousPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _previousPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdminDashboardProvider(),
      child: Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
          final current = provider.page;

          // keep pageController in sync when provider changes programmatically
          if (_pageController.hasClients &&
              _pageController.page?.round() != current) {
            _pageController.animateToPage(
              current,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }

          return Column(
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 6),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dashboard",
                            style: MoonTokens.light.typography.heading.text20,
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Center(child: Icon(Icons.person)),
                          ),
                        ],
                      ),
                    ),
                    MoonSegmentedControl(
                      isExpanded: true,
                      segmentedControlSize: MoonSegmentedControlSize.sm,
                      onSegmentChanged: (value) {
                        provider.page = value;
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            value,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      segments: provider.pages
                          .map(
                            (key) => Segment(
                              label: Text(
                                key,
                                style: MoonTokens.light.typography.body.text14,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    _previousPage = provider.page;
                    provider.page = index;
                  },
                  children: [Keuangan(), Kegiatan(), Kependudukan()],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
