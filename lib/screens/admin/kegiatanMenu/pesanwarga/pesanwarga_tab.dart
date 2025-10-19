import 'package:flutter/material.dart';
import 'edit_pesan_warga_screen.dart';
import 'detail_pesan_warga_screen.dart';

class PesanWarga {
  final String judul;
  final String pengirim;
  final String tanggalDibuat;
  final String id;
  String status;

  PesanWarga({
    required this.id,
    required this.judul,
    required this.pengirim,
    required this.tanggalDibuat,
    required this.status,
  });
}

List<PesanWarga> allPesan = [
  PesanWarga(id: 'p001', judul: 'Laporan Kebocoran Pipa', pengirim: 'Bu Kartini', tanggalDibuat: '15/10/2025', status: 'Pending'),
  PesanWarga(id: 'p002', judul: 'Pengaduan Parkir Liar', pengirim: 'Pak Budi', tanggalDibuat: '14/10/2025', status: 'Diterima'),
  PesanWarga(id: 'p003', judul: 'Permintaan Lampu Jalan', pengirim: 'Bpk. Ahmad', tanggalDibuat: '13/10/2025', status: 'Ditolak'),
  PesanWarga(id: 'p004', judul: 'Perbaikan Jalan Raya', pengirim: 'Bpk. Mamat', tanggalDibuat: '16/10/2025', status: 'Pending'),
  PesanWarga(id: 'p005', judul: 'Pembuatan Pos Ronda', pengirim: 'Ibu Rina', tanggalDibuat: '17/10/2025', status: 'Diterima'),
];

class PesanWargaScreen extends StatefulWidget {
  const PesanWargaScreen({super.key});

  @override
  State<PesanWargaScreen> createState() => _PesanWargaScreenState();
}

class _PesanWargaScreenState extends State<PesanWargaScreen> {
  String? _selectedStatus;
  String _searchText = '';

  List<PesanWarga> get _filteredPesan {
    Iterable<PesanWarga> result = allPesan;

    if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
      result = result.where((pesan) => pesan.status == _selectedStatus);
    }

    if (_searchText.isNotEmpty) {
      final query = _searchText.toLowerCase();
      result = result.where((pesan) =>
          pesan.pengirim.toLowerCase().contains(query) ||
          pesan.judul.toLowerCase().contains(query));
    }

    return result.toList();
  }

  // Tombol aksi (Detail, Edit, Hapus)
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
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

  void _handleEditResult(Map<String, String> updatedData) {
    final index = allPesan.indexWhere((pesan) => pesan.id == updatedData['id']);
    if (index != -1) {
      setState(() {
        allPesan[index].status = updatedData['status']!;
      });
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, PesanWarga pesan) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Hapus', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Apakah kamu yakin ingin menghapus pesan "${pesan.judul}"? Aksi ini tidak dapat dibatalkan.'),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade200,
              ),
              child: const Text('Batal'),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  allPesan.removeWhere((p) => p.id == pesan.id);
                });
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pesan "${pesan.judul}" berhasil dihapus!')),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.deepPurple.shade700;
        break;
      case 'Diterima':
        color = Colors.green.shade700;
        break;
      case 'Ditolak':
        color = Colors.red.shade700;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPesanCard(PesanWarga pesan) {
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      pesan.judul,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildStatusChip(pesan.status),
                ],
              ),
              const SizedBox(height: 6),
              Text(pesan.pengirim, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              Text('Tanggal dibuat: ${pesan.tanggalDibuat}', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              const Divider(height: 24, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(Icons.remove_red_eye_outlined, "Detail", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPesanWargaScreen(
                          pesan: {
                            'judul': pesan.judul,
                            'status': pesan.status,
                            'pengirim': pesan.pengirim,
                            'tanggalDibuat': pesan.tanggalDibuat,
                            'deskripsi': '...',
                          },
                        ),
                      ),
                    );
                  }),
                  _buildActionButton(Icons.edit_outlined, "Edit", () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPesanWargaScreen(pesan: {
                          'id': pesan.id,
                          'judul': pesan.judul,
                          'status': pesan.status,
                          'deskripsi': '...',
                        }),
                      ),
                    );
                    if (result != null && result is Map<String, String>) {
                      _handleEditResult(result);
                    }
                  }),
                  _buildActionButton(Icons.delete_outline, "Hapus", () => _showDeleteConfirmationDialog(context, pesan)),
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
    const primaryColor = Colors.deepPurple;
    final statusList = ['Pending', 'Diterima', 'Ditolak'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pesan Warga',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar + Dropdown Status
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
                      onChanged: (value) => setState(() => _searchText = value),
                      decoration: InputDecoration(
                        hintText: 'Cari Berdasarkan Nama atau Judul',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: _selectedStatus,
                      hint: const Text('Semua', style: TextStyle(fontSize: 14)),
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Semua'),
                        ),
                        ...statusList.map((s) => DropdownMenuItem<String?>(
                              value: s,
                              child: Text(s),
                            )),
                      ],
                      onChanged: (val) => setState(() => _selectedStatus = val),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📋 Daftar Pesan
          Expanded(
            child: _filteredPesan.isEmpty
                ? const Center(child: Text("Tidak ada pesan yang ditemukan."))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: _filteredPesan.length,
                    itemBuilder: (context, index) => _buildPesanCard(_filteredPesan[index]),
                  ),
          ),
        ],
      ),
      // ❇️ Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
