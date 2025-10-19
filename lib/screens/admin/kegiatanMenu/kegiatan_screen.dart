import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'broadcast/daftar_broadcast.dart';
import 'broadcast/tambah_broadcast.dart';
import 'pesanwarga/pesanwarga_tab.dart';

const List<Color> _gradient1 = [Color(0xFF8A2BE2), Color(0xFF9370DB)];
const List<Color> _gradient2 = [Color(0xFF7B68EE), Color(0xFF9932CC)];
const List<Color> _gradient3 = [Color(0xFF4B0082), Color(0xFF9932CC)];
const List<Color> _gradient4 = [Color(0xFFBA55D3), Color(0xFFDA70D6)];

void _showComingSoon(BuildContext context, String action, String menu) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('TODO: Navigasi ke Halaman $action $menu')),
  );
}

class KegiatanScreen extends StatelessWidget {
  const KegiatanScreen({super.key});

  // Fungsi navigasi umum
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _ExpandableMenuCard(
              title: 'Kegiatan',
              subtitle: 'Kelola data kegiatan',
              icon: Icons.event,
              gradientColors: _gradient1,
              onDaftarTap: () => context.push('/admin/kegiatan/daftar'),
              onTambahTap: () => context.push('/admin/kegiatan/tambah'),
            ),
            const SizedBox(height: 15),
            // PERUBAHAN DI SINI UNTUK MENU BROADCAST
            _ExpandableMenuCard(
              title: 'Broadcast',
              subtitle: 'Kelola data broadcast',
              icon: Icons.campaign,
              gradientColors: _gradient2,
              onDaftarTap: () =>
                  _navigateToScreen(context, const DaftarBroadcastScreen()),
              onTambahTap: () =>
                  _navigateToScreen(context, const TambahBroadcastScreen()),
            ),
            const SizedBox(height: 15),
            _DirectMenuCard(
              title: 'Pesan Warga',
              subtitle: 'Kelola pesan warga',
              icon: Icons.message,
              gradientColors: _gradient3,
              onTap: () => context.push('/admin/kegiatan/pesanwarga'),
            ),
            const SizedBox(height: 15),
            _DirectMenuCard(
              title: 'Log Aktivitas',
              subtitle: 'Lihat log aktivitas pengguna',
              icon: Icons.history,
              gradientColors: _gradient4,
              onTap: () => context.push('/admin/kegiatan/logaktivitas'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const _DirectMenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildIconContainer(icon),
            const SizedBox(width: 15),
            Expanded(child: _buildTextContent(title, subtitle)),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

  Widget _buildTextContent(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
        ),
      ],
    );
  }
}

class _ExpandableMenuCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onDaftarTap;
  final VoidCallback onTambahTap;
  final List<Color> gradientColors;

  const _ExpandableMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onDaftarTap,
    required this.onTambahTap,
    required this.gradientColors,
  });

  @override
  State<_ExpandableMenuCard> createState() => _ExpandableMenuCardState();
}

class _ExpandableMenuCardState extends State<_ExpandableMenuCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                _buildIconContainer(widget.icon),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTextContent(widget.title, widget.subtitle),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      label: 'Daftar',
                      icon: Icons.list_alt,
                      onTap: widget.onDaftarTap,
                    ),
                    _buildActionButton(
                      label: 'Tambah',
                      icon: Icons.add_circle,
                      onTap: widget.onTambahTap,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

  Widget _buildTextContent(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
