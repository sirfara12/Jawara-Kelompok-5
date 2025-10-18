import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';

class KeuanganMenuScreen extends StatelessWidget {
  const KeuanganMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      activeIndex: 2, // Keuangan tab
      title: 'Keuangan',
      body: Container(
        color: const Color(0xFFF8F9FA),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Menu',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              _buildGradientCard(
                context,
                icon: Icons.arrow_downward_rounded,
                title: 'Pemasukan',
                subtitle: 'Kelola data pemasukan dan iuran',
                gradientColors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                onTap: () {
                  context.push('/admin/pemasukan');
                },
              ),
              const SizedBox(height: 20),
              _buildGradientCard(
                context,
                icon: Icons.arrow_upward_rounded,
                title: 'Pengeluaran',
                subtitle: 'Kelola data pengeluaran',
                gradientColors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                onTap: () {
                  context.push('/admin/pengeluaran');
                },
              ),
              const SizedBox(height: 20),
              _buildGradientCard(
                context,
                icon: Icons.assessment_rounded,
                title: 'Laporan Keuangan',
                subtitle: 'Lihat laporan dan analisis keuangan',
                gradientColors: [Color(0xFFA855F7), Color(0xFFC084FC)],
                onTap: () {
                  context.push('/admin/laporan-keuangan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
