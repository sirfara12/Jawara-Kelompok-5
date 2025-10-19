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
  String _searchQuery = '';
  DateTime? _filterDate;
  String? _filterKategori;
  final TextEditingController _searchController = TextEditingController();
  final DateFormat logDateFormat = DateFormat('dd/MM/yyyy');
  
  List<Map<String, String>> _kegiatanList = [
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

  List<Map<String, String>> _filterKegiatan() {
    Iterable<Map<String, String>> result = _kegiatanList;

    // Filter Pencarian Judul
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((kegiatan) {
        final judul = kegiatan['judul']?.toLowerCase() ?? '';
        final pj = kegiatan['pj']?.toLowerCase() ?? '';
        return judul.contains(query) || pj.contains(query);
      });
    }

    // Filter Tanggal Pelaksanaan
    if (_filterDate != null) {
      result = result.where((kegiatan) {
        try {
          final kegiatanDate = logDateFormat.parse(kegiatan['tanggal']!);
          return kegiatanDate.isAtSameMomentAs(_filterDate!);
        } catch (e) {
          return false;
        }
      });
    }

    // Filter Kategori
    if (_filterKategori != null && _filterKategori != 'Semua Kategori') {
      result = result.where(
        (kegiatan) => kegiatan['kategori'] == _filterKategori,
      );
    }

    return result.toList();
  }

  // nav modal filter
  void _showFilterModal(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          // 
          height: MediaQuery.of(context).size.height * 0.75,
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

  // Nav tambah Kegiatan
  void _navigateToAddKegiatan(BuildContext context) async {
    final newKegiatan = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahKegiatanScreen()),
    );

    if (newKegiatan != null && newKegiatan is Map<String, String>) {
      if (newKegiatan['judul'] != null && newKegiatan['judul']!.isNotEmpty) {
        setState(() {
          _kegiatanList.add({
            'judul': newKegiatan['judul']!,
            'pj': newKegiatan['pj']!,
            'tanggal': newKegiatan['tanggal']!,
            'kategori': newKegiatan['kategori']!,
            'lokasi': newKegiatan['lokasi'] ?? '',
            'deskripsi': newKegiatan['deskripsi'] ?? '',
            'dibuat_oleh': 'Anda (Admin)',
            'has_docs': 'false',
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Kegiatan baru "${newKegiatan['judul']}" berhasil ditambahkan!',
            ),
            backgroundColor: Colors.green.shade600,
          ),
        );
      }
    }
  }

  //Nav Edit Kegiatan
  void _navigateToEditKegiatan(
    BuildContext context,
    Map<String, String> kegiatanSaatIni,
    int index,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditKegiatanScreen(kegiatan: kegiatanSaatIni),
      ),
    );

    if (result != null) {
      setState(() {
        if (result is Map<String, String> && result['status'] == 'deleted') {
          _kegiatanList.removeAt(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Kegiatan berhasil dihapus!'), backgroundColor: Colors.red.shade600),
          );
        } else if (result is Map<String, String>) {
          if (result['judul'] != null) {
            _kegiatanList[index] = result;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Kegiatan "${result['judul']}" berhasil diubah!'),
                backgroundColor: Colors.blue.shade600,
              ),
            );
          }
        }
      });
    }
  }

  // Dialog Konfirmasi Hapus
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    final String judulKegiatan = _kegiatanList[index]['judul'] ?? 'Item';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Konfirmasi Hapus',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus kegiatan "$judulKegiatan"? Aksi ini tidak dapat dibatalkan.',
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _kegiatanList.removeAt(index);
                });
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Kegiatan "$judulKegiatan" berhasil dihapus!',
                    ),
                    backgroundColor: Colors.red.shade600,
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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
    final originalList = _kegiatanList; 
    const primaryColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(), 
        ),
        title: const Text(
          'Kegiatan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: false, 
        backgroundColor: Colors.white,
        elevation: 0, 
        toolbarHeight: 50, 
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BARIS SEARCH DAN FILTER
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40, 
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search Name', 
                              prefixIcon: const Icon(Icons.search, color: Colors.grey), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.grey), 
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: primaryColor, width: 1.0),
                              ),
                              filled: true,
                              fillColor: Colors.white, 
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Tombol Filter
                      Container(
                        width: 40, 
                        height: 40, 
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.tune, color: Colors.black, size: 24),
                          onPressed: () => _showFilterModal(context),
                          padding: EdgeInsets.zero,
                          splashRadius: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                // List Kegiatan
                Expanded(
                  child: filteredList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.event_note, size: 60, color: Colors.grey.shade300),
                              const SizedBox(height: 10),
                              Text(
                                _searchQuery.isNotEmpty || _filterDate != null || _filterKategori != null
                                    ? "Tidak ada kegiatan yang cocok dengan filter."
                                    : "Belum ada kegiatan yang ditambahkan.",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,
                          padding: const EdgeInsets.only(bottom: 90), 
                          itemBuilder: (context, filterIndex) {
                            final kegiatan = filteredList[filterIndex];

                            final originalIndex = originalList.indexOf(kegiatan);

                            return KegiatanCard(
                              kegiatan: kegiatan,
                              onEdit: () {
                                _navigateToEditKegiatan(
                                  context,
                                  kegiatan,
                                  originalIndex,
                                );
                              },
                              onDelete: () {
                                _showDeleteConfirmationDialog(context, originalIndex);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          // Floating Action Button (Tombol Tambah)
          Positioned(
            bottom: 16.0, 
            right: 16.0, 
            child: FloatingActionButton(
              onPressed: () => _navigateToAddKegiatan(context),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), 
              ),
              elevation: 8,
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan satu item Kegiata
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

  void _navigateToDetail(BuildContext context, Map<String, String> kegiatan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailKegiatanScreen(kegiatan: kegiatan),
      ),
    );
  }

  // Widget pembangun tombol aksi individual (Detail, Edit, Hapus)
  Widget _buildActionTextIcon(IconData icon, String label, VoidCallback onTap) {
      const Color actionIconColor = Color(0xFF5F5D70); 

      return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), 
              child: Row(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                      Icon(icon, size: 16, color: actionIconColor), 
                      const SizedBox(width: 4),
                      Text(
                          label,
                          style: const TextStyle(
                              fontSize: 14,
                              color: actionIconColor,
                              fontWeight: FontWeight.w600,
                          ),
                      ),
                  ],
              ),
          ),
      );
  }


  @override
  Widget build(BuildContext context) {
    const Color categoryColor = Color(0xFF5E65C0); 

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JUDUL & KATEGORI
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
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                      ),
                      Text(
                        'Tanggal Pelaksanaan : ${kegiatan['tanggal']}',
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                // KATEGORI (Badge Sosial)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
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
            
            const Divider(height: 25, color: Color.fromARGB(255, 230, 230, 230)), 

            // AKSI: Detail, Edit, Hapus
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  Detail
                _buildActionTextIcon(
                  Icons.remove_red_eye, 
                  'Detail', 
                  () => _navigateToDetail(context, kegiatan),
                ),
                
                // Tombol Edit
                if (isAdmin)
                  _buildActionTextIcon(Icons.edit, 'Edit', onEdit),
                
                // Tombol Hapus
                if (isAdmin)
                  _buildActionTextIcon(Icons.delete, 'Hapus', onDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}