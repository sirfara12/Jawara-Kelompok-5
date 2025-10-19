import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tambah_broadcast.dart';
import 'edit_broadcast_screen.dart';
import 'detail_broadcast_screen.dart';
import 'broadcast_filter_screen.dart';


class KegiatanBroadcast {
  final String judul;
  final String pengirim;
  final String tanggal;
  final String kategori;
  final String konten;
  final String? lampiranGambarUrl;
  final List<String> lampiranDokumen;

  KegiatanBroadcast({
    required this.judul,
    required this.pengirim,
    required this.tanggal,
    required this.konten,
    this.kategori = "Pemberitahuan",
    this.lampiranGambarUrl,
    this.lampiranDokumen = const [],
  });
}
List<KegiatanBroadcast> dummyData = [
  KegiatanBroadcast(
    judul: "Pemberitahuan Kerja Bakti",
    pengirim: "Ketua RT",
    tanggal: "12/10/2025",
    konten:
        "PENGUMUMAN — Kepada seluruh warga RT 03/RW 07, besok Minggu pukul 07.00 akan diadakan kerja bakti membersihkan selokan dan lingkungan sekitar. Diharapkan semua warga ikut berpartisipasi. Terima kasih",
    lampiranGambarUrl: "assets/kerjabakti.png",
    lampiranDokumen: ["file_panduan.pdf", "file_absensi.pdf"],
  ),
  KegiatanBroadcast(
    judul: "Himbauan Pembayaran Iuran",
    pengirim: "Bendahara RT",
    tanggal: "15/10/2025",
    kategori: "Keuangan",
    konten:
        "Dimohon segera melunasi iuran bulanan sebelum tanggal 20. Bagi yang belum membayar, harap segera menghubungi Bendahara RT.",
    lampiranGambarUrl: "assets/kerjabakti.png",
    lampiranDokumen: ["laporan_keuangan.pdf"],
  ),
  KegiatanBroadcast(
    judul: "Undangan Rapat Program",
    pengirim: "Sekretaris RW",
    tanggal: "20/10/2025",
    kategori: "Pemberitahuan",
    konten:
        "Rapat Program Kerja akan diadakan pada hari Rabu di Balai Warga. Kehadiran para ketua RT/RW sangat diharapkan.",
    lampiranGambarUrl: null,
    lampiranDokumen: [],
  ),
];
class DaftarBroadcastScreen extends StatefulWidget {
  const DaftarBroadcastScreen({super.key});

  @override
  State<DaftarBroadcastScreen> createState() => _DaftarBroadcastScreenState();
}

class _DaftarBroadcastScreenState extends State<DaftarBroadcastScreen> {
  String _searchQuery = '';
  DateTime? _filterDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _searchController = TextEditingController();


  List<KegiatanBroadcast> _filterBroadcast() {
    // Logika filter
    Iterable<KegiatanBroadcast> result = dummyData;
    final query = _searchQuery.toLowerCase();

    // Filter pencarian
    if (_searchQuery.isNotEmpty) {
      result = result.where((broadcast) {
        final judul = broadcast.judul.toLowerCase();
        final pengirim = broadcast.pengirim.toLowerCase();
        return judul.contains(query) || pengirim.contains(query);
      });
    }

    // Filter Tanggal
    if (_filterDate != null) {
      result = result.where((broadcast) {
        try {
          final broadcastDate = _dateFormat.parse(broadcast.tanggal);
          return broadcastDate.isAtSameMomentAs(_filterDate!);
        } catch (e) {
          return false;
        }
      });
    }

    return result.toList();
  }

  void _showFilterModal(BuildContext context) async {
    // Logika Modal Filter 
    final result = await showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20, bottom: MediaQuery.of(modalContext).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: BroadcastFilterScreen(initialDate: _filterDate),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _filterDate = result['date'] as DateTime?;
        _searchController.clear();
        _searchQuery = ''; 
      });
    }
  }

  void _navigateToEditBroadcast(
    BuildContext context,
    KegiatanBroadcast broadcastSaatIni,
    int index,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditBroadcastScreen(initialBroadcastData: broadcastSaatIni),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (result['status'] == 'updated') {
          final updatedData = KegiatanBroadcast(
            judul: result['judul'],
            konten: result['konten'],
            pengirim: broadcastSaatIni.pengirim,
            tanggal: broadcastSaatIni.tanggal,
            kategori: broadcastSaatIni.kategori,
            lampiranGambarUrl: broadcastSaatIni.lampiranGambarUrl,
            lampiranDokumen: broadcastSaatIni.lampiranDokumen,
          );
          dummyData[index] = updatedData;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Broadcast "${result['judul']}" berhasil diubah!'),
            ),
          );
        }
      });
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    // Logika dialog hapus
    final String judulBroadcast = dummyData[index].judul;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Konfirmasi Hapus',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus broadcast "$judulBroadcast"? Aksi ini tidak dapat dibatalkan.',
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade200,
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
                  dummyData.removeAt(index);
                });
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Broadcast "$judulBroadcast" berhasil dihapus!',
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
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

  void _navigateToDetail(BuildContext context, KegiatanBroadcast data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBroadcastScreen(broadcastData: data),
      ),
    );
  }

  // Fungsi navigasi ke Tambah Broadcast
  void _navigateToAddBroadcast() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahBroadcastScreen(),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
        final newBroadcast = KegiatanBroadcast(
          judul: result['judul'] ?? 'Broadcast Baru',
          konten: result['isi'] ?? 'Tanpa isi',
          pengirim: 'Admin RT', 
          tanggal: _dateFormat.format(DateTime.now()), 
          kategori: 'Pemberitahuan',
        );
        setState(() {
          dummyData.insert(0, newBroadcast);
        });
    }
  }
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildBroadcastCard(
    KegiatanBroadcast kegiatan, {
    required VoidCallback onDetail,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    // Warna Teks Detail
    final Color detailColor = Colors.grey.shade700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kegiatan.judul,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),              
              Row(
                children: [
                  Text(
                    kegiatan.pengirim,
                    style: TextStyle(fontSize: 14, color: detailColor),
                  ),
                  const Text(' • ', style: TextStyle(color: Colors.grey)),
                  Text(
                    "Tanggal : ${kegiatan.tanggal}",
                    style: TextStyle(fontSize: 14, color: detailColor),
                  ),
                ],
              ),
              
              const Divider(height: 24, thickness: 0.5),

              // Tombol Aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildActionButton(
                      Icons.remove_red_eye_outlined, "Detail", onDetail),
                  const SizedBox(width: 16),
                  _buildActionButton(Icons.edit_outlined, "Edit", onEdit),
                  const SizedBox(width: 16),
                  _buildActionButton(Icons.delete_outline, "Hapus", onDelete),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final filteredList = _filterBroadcast();
    const Color primaryColor = Color(0xFF673AB7);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Name', 
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Tombol Filter
                IconButton(
                  icon: Icon(Icons.tune, color: Colors.grey.shade700, size: 28),
                  onPressed: () => _showFilterModal(context),
                  tooltip: 'Filter',
                ),
              ],
            ),
          ),

          // Daftar Kegiatan
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text("Tidak ada Broadcast yang ditemukan."))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filteredList.length,
                    itemBuilder: (context, filterIndex) {
                      final kegiatan = filteredList[filterIndex];
                      final originalIndex = dummyData.indexOf(kegiatan);

                      return _buildBroadcastCard(
                        kegiatan,
                        onDetail: () => _navigateToDetail(context, kegiatan),
                        onEdit: () {
                          _navigateToEditBroadcast(
                            context,
                            kegiatan,
                            originalIndex,
                          );
                        },
                        onDelete: () {
                          _showDeleteConfirmationDialog(
                              context, originalIndex);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddBroadcast,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}