import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart' show Iconify;
import 'package:jawara_pintar_kel_5/constants/constant_colors.dart';
import 'package:jawara_pintar_kel_5/constants/iconify.dart';
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';
import 'package:jawara_pintar_kel_5/widget/dashboard_count_card.dart';
import 'package:moon_design/moon_design.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Map<String, Widget> _pages = {
    'Keuangan': const Text('Keuangan'),
    'Kegiatan': const Text('Kegiatan'),
    'Kependudukan': const Text('Kependudukan'),
  };

  Future<dynamic> bottomSheetBuilder(BuildContext context) {
    return showMoonModalBottomSheet(
      context: context,
      enableDrag: true,
      height: MediaQuery.of(context).size.height * 0.7,
      builder: (BuildContext context) => Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: ShapeDecoration(
              color: context.moonColors!.beerus,
              shape: MoonSquircleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ).squircleBorderRadius(context),
              ),
            ),
          ),
          const Expanded(child: Align(child: Text('MoonBottomSheet'))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      activeIndex: 0,
      body: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 6),
        child: Column(
          spacing: 8,
          children: [
            Column(
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
                  segments: _pages.keys
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jumlah Transaksi',
                            style: MoonTokens.light.typography.heading.text20
                                .copyWith(color: ConstantColors.foreground2),
                          ),
                          Text(
                            '1',
                            style: MoonTokens.light.typography.heading.text20,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: MoonDropdown(
                          show: false,
                          content: const SizedBox.shrink(),
                          child: MoonTextInput(
                            textInputSize: MoonTextInputSize.md,
                            readOnly: true,
                            hintText: '2025',
                            onTap: () => bottomSheetBuilder(context),
                            trailing: Icon(
                              MoonIcons
                                  .controls_vertical_double_chevron_32_light,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final spacing = 6.0;
                      final width = constraints.maxWidth / 2 - spacing;
                      return Row(
                        spacing: spacing,
                        children: [
                          DashboardCountCard(
                            width: width,
                            title: 'Pemasukan',
                            count: '10K',
                            icon: Iconify(
                              IconifyConstants.fluentArrowDown,
                              color: MoonTokens.light.colors.roshi,
                              size: 12,
                            ),
                          ),
                          DashboardCountCard(
                            width: width,
                            title: 'Pengeluaran',
                            count: '10K',
                            icon: Iconify(
                              IconifyConstants.fluentArrowUp,
                              color: MoonTokens.light.colors.dodoria,
                              size: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
