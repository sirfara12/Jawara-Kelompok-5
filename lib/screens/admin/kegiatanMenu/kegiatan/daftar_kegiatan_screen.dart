import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/tambah_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/detail_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/edit_kegiatan_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/kegiatanMenu/kegiatan/kegiatan_filter_screen.dart';

class DaftarKegiatanScreen extends StatefulWidget {
  const DaftarKegiatanScreen({super.key});

  @override
  State<DaftarKegiatanScreen> createState() => _DaftarKegiatanScreenState();
}

class _DaftarKegiatanScreenState extends State<DaftarKegiatanScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DateFormat logDateFormat = DateFormat('dd/MM/yyyy');

  String _searchQuery = '';
  DateTime? _filterDate;
  String? _filterKategori;

  final List<Map<String, String>> _kegiatanList = [
    {
      'judul': 'Kerja Bakti Lingkungan',
      'pj': 'Pak Habibi',
      'tanggal': '12/10/2025',
      'kategori': 'Sosial',
      'lokasi': 'Balai Warga RW 01',
      'deskripsi':
          'Kerja bakti membersihkan lingkungan dari sampah dan selokan untuk menjaga kebersihan dan keamanan lingkungan.',
      'dibuat_oleh': 'Admin Jawara',
      'has_docs': 'true',
    },
    {
      'judul': 'Lomba Hafalan Al-Quran',
      'pj': 'DMI',
      'tanggal': '01/11/2025',
      'kategori': 'Keagamaan',
      'lokasi': 'Masjid Al-Ikhlas',
      'deskripsi':
          'Lomba diadakan untuk memperingati Maulid Nabi dan meningkatkan pemahaman agama.',
      'dibuat_oleh': 'Admin Jawara',
      'has_docs': 'false',
    },
    {
      'judul': 'Pelatihan Keterampilan Digital',
      'pj': 'Karang Taruna',
      'tanggal': '25/10/2025',
      'kategori': 'Pendidikan',
      'lokasi': 'Aula Kecamatan',
      'deskripsi':
          'Pelatihan dasar desain grafis dan coding untuk remaja yang tertarik pada teknologi.',
      'dibuat_oleh': 'Admin Jawara',
      'has_docs': 'true',
    },
    {
      'judul': 'Senam Pagi Massal',
      'pj': 'Puskesmas Keliling',
      'tanggal': '15/10/2025',
      'kategori': 'Kesehatan & Olahraga',
      'lokasi': 'Lapangan Bola',
      'deskripsi':
          'Senam rutin untuk meningkatkan kebugaran warga dan mempererat tali silaturahmi.',
      'dibuat_oleh': 'Admin Jawara',
      'has_docs': 'false',
    },
  ];

  // =========================== FILTER ======================================

  List<Map<String, String>> _filterKegiatan() {
    Iterable<Map<String, String>> result = _kegiatanList;

    // Filter Pencarian Judul / PJ
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((kegiatan) {
        final judul = kegiatan['judul']?.toLowerCase() ?? '';
        final pj = kegiatan['pj']?.toLowerCase() ?? '';
        return judul.contains(query) || pj.contains(query);
      });
    }

    // Filter Berdasarkan Tanggal
    if (_filterDate != null) {
      result = result.where((kegiatan) {
        try {
          final kegiatanDate = logDateFormat.parse(kegiatan['tanggal']!);
          return kegiatanDate.isAtSameMomentAs(_filterDate!);
        } catch (_) {
          return false;
        }
      });
    }

    // Filter Berdasarkan Kategori
    if (_filterKategori != null && _filterKategori != 'Semua Kategori') {
      result = result.where((kegiatan) =>
          kegiatan['kategori']?.toLowerCase() ==
          _filterKategori?.toLowerCase());
    }

    return result.toList();
  }

  void _showFilterModal(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(modalContext).viewInsets.bottom,
            ),
            child: KegiatanFilterScreen(
              initialDate: _filterDate,
              initialKategori: _filterKategori,
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _filterDate = result['date'] as DateTime?;
        _filterKategori = result['kategori'] as String?;
      });
    }
  }

  void _navigateToAddKegiatan(BuildContext context) async {
    final newKegiatan = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahKegiatanScreen()),
    );

    if (newKegiatan != null && newKegiatan is Map<String, String>) {
      if (newKegiatan['judul']?.isNotEmpty ?? false) {
        setState(() {
          _kegiatanList.add({
            ...newKegiatan,
            'dibuat_oleh': 'Anda (Admin)',
            'has_docs': 'false',
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Kegiatan baru "${newKegiatan['judul']}" berhasil ditambahkan!'),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    }
  }

  void _navigateToEditKegiatan(
      BuildContext context, Map<String, String> kegiatan, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditKegiatanScreen(kegiatan: kegiatan),
      ),
    );

    if (result != null) {
      setState(() {
        if (result is Map<String, String> && result['status'] == 'deleted') {
          _kegiatanList.removeAt(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Kegiatan berhasil dihapus!'),
              backgroundColor: Colors.red.shade600,
            ),
          );
        } else if (result is Map<String, String>) {
          _kegiatanList[index] = result;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Kegiatan "${result['judul']}" berhasil diperbarui!'),
              backgroundColor: Colors.blue.shade600,
            ),
          );
        }
      });
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    final judulKegiatan = _kegiatanList[index]['judul'] ?? 'Item';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Colors.white, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Konfirmasi Hapus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
        content: Text(
          'Apakah kamu yakin ingin menghapus kegiatan "$judulKegiatan"? Aksi ini tidak dapat dibatalkan.',
          // Teks konten diubah menjadi gelap
          style: const TextStyle(color: Colors.black87), 
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade400, 
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Batal'),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _kegiatanList.removeAt(index);
              });
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kegiatan "$judulKegiatan" berhasil dihapus!'),
                  backgroundColor: Colors.grey.shade800,
                ),
              );
            },
            style: TextButton.styleFrom(
              // **Tombol Hapus:** Latar Ungu, Teks Putih (Sesuai dengan gambar)
              backgroundColor: Colors.deepPurple, 
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    final filteredList = _filterKegiatan();
    const primaryColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kegiatan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          // Search Bar dan Filter Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Cari Berdasarkan Judul',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.tune, color: Colors.black87, size: 22),
                    onPressed: () => _showFilterModal(context),
                    tooltip: 'Filter',
                  ),
                ),
              ],
            ),
          ),

          // dftr kgtan
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_note,
                            size: 60, color: Colors.grey.shade300),
                        const SizedBox(height: 10),
                        Text(
                          _searchQuery.isNotEmpty ||
                                  _filterDate != null ||
                                  _filterKategori != null
                              ? "Tidak ada kegiatan yang cocok dengan filter."
                              : "Belum ada kegiatan yang ditambahkan.",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: filteredList.length,
                    itemBuilder: (_, index) {
                      final kegiatan = filteredList[index];
                      final originalIndex = _kegiatanList.indexOf(kegiatan);
                      return KegiatanCard(
                        kegiatan: kegiatan,
                        onEdit: () =>
                            _navigateToEditKegiatan(context, kegiatan, originalIndex),
                        onDelete: () =>
                            _showDeleteConfirmationDialog(context, originalIndex),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddKegiatan(context),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
class KegiatanCard extends StatelessWidget {
  final Map<String, String> kegiatan;
  final bool isAdmin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const KegiatanCard({
    super.key,
    required this.kegiatan,
    this.isAdmin = true,
    required this.onEdit,
    required this.onDelete,
  });

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailKegiatanScreen(kegiatan: kegiatan),
      ),
    );
  }

  Widget _buildActionTextIcon(
      IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F2FA),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF5F5D70)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5F5D70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const categoryColor = Color(0xFF5E65C0);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== Header: Judul + Kategori ======
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kegiatan['judul']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Penanggung Jawab : ${kegiatan['pj']}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Tanggal Pelaksanaan : ${kegiatan['tanggal']}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    kegiatan['kategori']!,
                    style: const TextStyle(
                      color: categoryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25, color: Color(0xFFE6E6E6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionTextIcon(
                    Icons.remove_red_eye, 'Detail', () => _navigateToDetail(context)),
                if (isAdmin) _buildActionTextIcon(Icons.edit, 'Edit', onEdit),
                if (isAdmin) _buildActionTextIcon(Icons.delete, 'Hapus', onDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
