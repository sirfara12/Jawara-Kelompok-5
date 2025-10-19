import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KeuanganMenuScreen extends StatelessWidget {
  const KeuanganMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Keuangan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
              // Pemasukan card with inline menu items
              _buildMenuCard(
                context,
                icon: Icons.arrow_downward_rounded,
                title: 'Pemasukan',
                subtitle: 'Kelola data pemasukan dan iuran',
                gradientColors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                menuItems: [
                  MenuItem(
                    icon: Icons.category_outlined,
                    label: 'Kategori Iuran',
                    onTap: () =>
                        context.push('/admin/pemasukan/kategori-iuran'),
                  ),
                  MenuItem(
                    icon: Icons.payments_outlined,
                    label: 'Tagih Iuran',
                    onTap: () => context.push('/admin/pemasukan/tagih-iuran'),
                  ),
                  MenuItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Tagihan',
                    onTap: () => context.push('/admin/pemasukan/tagihan'),
                  ),
                  MenuItem(
                    icon: Icons.attach_money_outlined,
                    label: 'Pemasukan Lain',
                    onTap: () =>
                        context.push('/admin/pemasukan/pemasukan-lain'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Pengeluaran card with inline menu items
              _buildMenuCard(
                context,
                icon: Icons.arrow_upward_rounded,
                title: 'Pengeluaran',
                subtitle: 'Kelola data pengeluaran',
                gradientColors: const [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                menuItems: [
                  MenuItem(
                    icon: Icons.list_alt_outlined,
                    label: 'Daftar',
                    onTap: () => context.push('/admin/pengeluaran/daftar'),
                  ),
                  MenuItem(
                    icon: Icons.add_circle_outline,
                    label: 'Tambah',
                    onTap: () => context.push('/admin/pengeluaran/tambah'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Laporan Keuangan card with inline menu items
              _buildMenuCard(
                context,
                icon: Icons.assessment_rounded,
                title: 'Laporan Keuangan',
                subtitle: 'Lihat laporan dan analisis keuangan',
                gradientColors: const [Color(0xFFA855F7), Color(0xFFC084FC)],
                menuItems: [
                  MenuItem(
                    icon: Icons.trending_down_outlined,
                    label: 'Semua Pemasukan',
                    onTap: () => context.push('/admin/laporan/semua-pemasukan'),
                  ),
                  MenuItem(
                    icon: Icons.trending_up_outlined,
                    label: 'Semua Pengeluaran',
                    onTap: () =>
                        context.push('/admin/laporan/semua-pengeluaran'),
                  ),
                  MenuItem(
                    icon: Icons.print_outlined,
                    label: 'Cetak Laporan',
                    onTap: () => context.push('/admin/laporan/cetak-laporan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build menu card with grid icon layout (GoPay style)
  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required List<MenuItem> menuItems,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
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
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
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
                ],
              ),
              const SizedBox(height: 20),
              // Grid menu items (GoPay style) - Max 4 columns
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: menuItems.length < 4 ? menuItems.length : 4,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildGridIconButton(
                    context,
                    icon: item.icon,
                    label: item.label,
                    onTap: item.onTap,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build individual grid icon button (GoPay style)
  Widget _buildGridIconButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MenuItem model class
class MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  MenuItem({required this.icon, required this.label, required this.onTap});
}
