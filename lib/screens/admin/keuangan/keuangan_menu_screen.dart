import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/widget/gradient_menu_card.dart';

class KeuanganMenuScreen extends StatelessWidget {
  const KeuanganMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Keuangan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
            GradientMenuCard(
              icon: Icons.arrow_downward_rounded,
              title: 'Pemasukan',
              subtitle: 'Kelola data pemasukan dan iuran',
              gradientColors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              onTap: () => context.push('/admin/pemasukan'),
            ),
            const SizedBox(height: 20),
            GradientMenuCard(
              icon: Icons.arrow_upward_rounded,
              title: 'Pengeluaran',
              subtitle: 'Kelola data pengeluaran',
              gradientColors: const [Color(0xFF8B5CF6), Color(0xFFA855F7)],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Halaman Pengeluaran belum tersedia'),
                    backgroundColor: Color(0xFF8B5CF6),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            GradientMenuCard(
              icon: Icons.assessment_rounded,
              title: 'Laporan Keuangan',
              subtitle: 'Lihat laporan dan analisis keuangan',
              gradientColors: const [Color(0xFFA855F7), Color(0xFFC084FC)],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Halaman Laporan Keuangan belum tersedia'),
                    backgroundColor: Color(0xFFA855F7),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
