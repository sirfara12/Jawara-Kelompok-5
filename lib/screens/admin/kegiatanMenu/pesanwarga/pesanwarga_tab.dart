import 'package:flutter/material.dart';
// Ganti dengan path yang sesuai di proyek Anda
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

class PesanWargaScreen extends StatelessWidget {
  const PesanWargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget currentBody = const _PesanWargaContent(); 

    return Scaffold(
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.white, 
        centerTitle: false, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pesan Warga',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, 
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      
      body: currentBody, 

    );
  }
}

class _PesanWargaContent extends StatefulWidget {
  const _PesanWargaContent({super.key});

  @override
  State<_PesanWargaContent> createState() => _PesanWargaContentState();
}

class _PesanWargaContentState extends State<_PesanWargaContent> {
  // Logic state
  String _searchText = '';
  String? _selectedStatus; 
  final List<String> _statusList = ['Pending', 'Diterima', 'Ditolak'];
  
  static const Color _customBorderColor = Color(0xFFE0E0E0); 
  static const double _borderRadius = 10.0; 

  // getter yang mengimplementasikan Pencarian dan Filter
  List<PesanWarga> get _filteredPesan {
    Iterable<PesanWarga> result = allPesan;
    if (_selectedStatus != null) {
      result = result.where((pesan) => pesan.status == _selectedStatus);
    }
    if (_searchText.isNotEmpty) {
      final query = _searchText.toLowerCase();
      result = result.where((pesan) => pesan.pengirim.toLowerCase().contains(query));
    }
    return result.toList();
  }

  // hasil balik dari screen Edit
  void _handleEditResult(Map<String, String> updatedData) {
    final index = allPesan.indexWhere((pesan) => pesan.id == updatedData['id']);
    if (index != -1) {
      setState(() {
        allPesan[index].status = updatedData['status']!; 
      });
    }
  }

  // dialog hps
  void _showDeleteConfirmationDialog(BuildContext context, PesanWarga pesan) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Hapus', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Apakah kamu yakin ingin menghapus pesan "${pesan.judul}"? Aksi ini tidak dapat dibatalkan.'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() { allPesan.removeWhere((p) => p.id == pesan.id); });
                Navigator.of(dialogContext).pop(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pesan "${pesan.judul}" berhasil dihapus!')),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }


  // Widget Status Chip
  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Pending': color = Colors.deepPurple.shade700; break;
      case 'Diterima': color = Colors.green.shade700; break;
      case 'Ditolak': color = Colors.red.shade700; break;
      default: color = Colors.grey;
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

  // widget tombol aksi (Hanya Ikon, Sesuai Desain)
  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    final Color actionColor = Colors.grey.shade600; 
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0), 
        child: Icon(icon, size: 18, color: actionColor),
      ),
    );
  }

  // Widget Item Daftar Pesan
  Widget _buildPesanItem(BuildContext context, PesanWarga pesan) {
    
    void handleDetail() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPesanWargaScreen(
            pesan: {'judul': pesan.judul, 'deskripsi': '...', 'status': pesan.status, 'pengirim': pesan.pengirim, 'tanggalDibuat': pesan.tanggalDibuat,},
          ),
        ),
      );
    }
    
    void handleEdit() async {
      final dataToEdit = {'id': pesan.id, 'judul': pesan.judul, 'deskripsi': '...', 'status': pesan.status,};
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPesanWargaScreen(pesan: dataToEdit)),
      );
      if (result != null && result is Map<String, String>) {
        _handleEditResult(result); 
      }
    }
    
    void handleDelete() {
        _showDeleteConfirmationDialog(context, pesan);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    pesan.judul,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                _buildStatusChip(pesan.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(pesan.pengirim, style: TextStyle(fontSize: 14.0, color: Colors.grey.shade700)),
            Text('Tanggal dibuat : ${pesan.tanggalDibuat}', style: TextStyle(fontSize: 14.0, color: Colors.grey.shade700)),
            
            const Divider(height: 16, thickness: 1), 
            
            // Aksi (Hanya Ikon)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildActionButton(Icons.visibility_outlined, handleDetail), 
                _buildActionButton(Icons.edit_outlined, handleEdit),
                _buildActionButton(Icons.delete_outline, handleDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    border: Border.all(color: _customBorderColor), 
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() => _searchText = value),
                    decoration: const InputDecoration(
                      hintText: 'Search Name',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      isDense: true, 
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Dropdown Status Filter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(_borderRadius), 
                  border: Border.all(color: _customBorderColor), 
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    selectedItemBuilder: (BuildContext context) {
                      return [null, ..._statusList].map((String? status) {
                        String displayText = status ?? 'Semua Status';
                        return Center(
                          child: Text(displayText, style: const TextStyle(color: Colors.black, fontSize: 14)),
                        );
                      }).toList();
                    },
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 24),
                    items: [
                      const DropdownMenuItem<String>(value: null, child: Text('Semua Status', style: TextStyle(color: Colors.black, fontSize: 14))),
                      ..._statusList.map((String status) => DropdownMenuItem<String>(value: status, child: Text(status, style: const TextStyle(color: Colors.black, fontSize: 14)))),
                    ],
                    onChanged: (String? newValue) => setState(() => _selectedStatus = newValue),
                    dropdownColor: Colors.white, 
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        //list hasil filter
        Expanded(
          child: _filteredPesan.isEmpty
              ? const Center(child: Text("Tidak ada pesan yang ditemukan."))
              : ListView.builder(
                  itemCount: _filteredPesan.length,
                  itemBuilder: (context, index) {
                    final pesan = _filteredPesan[index];
                    return _buildPesanItem(context, pesan);
                  },
                ),
        ),
      ],
    );
  }
}