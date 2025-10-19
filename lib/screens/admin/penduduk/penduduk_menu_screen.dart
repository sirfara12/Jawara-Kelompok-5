import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/widget/gradient_menu_card.dart';

class PendudukMenuScreen extends StatelessWidget {
  const PendudukMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Penduduk',
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
              icon: Icons.people_rounded,
              title: 'Warga',
              subtitle: 'Kelola data warga dan penduduk',
              gradientColors: const [Color(0xFF4E46B4), Color(0xFF6366F1)],
              onTap: () => context.pushNamed('wargaList'),
            ),
            const SizedBox(height: 20),
            GradientMenuCard(
              icon: Icons.home_rounded,
              title: 'Rumah',
              subtitle: 'Kelola data rumah dan bangunan',
              gradientColors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              onTap: () => context.pushNamed('rumahList'),
            ),
            const SizedBox(height: 20),
            GradientMenuCard(
              icon: Icons.family_restroom_rounded,
              title: 'Keluarga',
              subtitle: 'Kelola data keluarga',
              gradientColors: const [Color(0xFF8B5CF6), Color(0xFFA855F7)],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Halaman Keluarga belum tersedia'),
                    backgroundColor: Color(0xFF8B5CF6),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            GradientMenuCard(
              icon: Icons.person_add_rounded,
              title: 'Penerimaan Warga',
              subtitle: 'Kelola pengajuan penerimaan warga baru',
              gradientColors: const [Color(0xFFA855F7), Color(0xFFC084FC)],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Halaman Penerimaan Warga belum tersedia'),
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
