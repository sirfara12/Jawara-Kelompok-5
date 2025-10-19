import 'package:flutter/material.dart';

class DetailKegiatanScreen extends StatelessWidget {
  final Map<String, String> kegiatan;
  const DetailKegiatanScreen({super.key, required this.kegiatan});

  Widget _buildDetailField(String label, String value, {int? maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value.isEmpty ? '-' : value,
          readOnly: true,
          style: const TextStyle(color: Colors.black87),
          maxLines: maxLines,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            fillColor: Color(0xFFF5F5F5),
            filled: true,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String namaKegiatan = kegiatan['judul'] ?? 'Nama Kegiatan Tidak Ada';
    final String kategori = kegiatan['kategori'] ?? 'Lainnya';
    final String deskripsi = kegiatan['deskripsi'] ?? 'Deskripsi Belum Tersedia';
    final String tanggal = kegiatan['tanggal'] ?? '-';
    final String lokasi = kegiatan['lokasi'] ?? 'Belum Ditentukan';
    final String pj = kegiatan['pj'] ?? '-';
    final String dibuatOleh = kegiatan['dibuat_oleh'] ?? 'Admin Jawara';


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Divider(height: 1, color: Colors.grey),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailField('Nama Kegiatan', namaKegiatan),
            _buildDetailField('Kategori', kategori),
            _buildDetailField('Deskripsi', deskripsi, maxLines: null),
            _buildDetailField('Tanggal', tanggal),
            _buildDetailField('Lokasi', lokasi),
            _buildDetailField('Penanggung Jawab', pj),
            _buildDetailField('Dibuat Oleh', dibuatOleh),

            const SizedBox(height: 16),
            
            // dokumentasi
            const Text(
              'Dokumentasi Event',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade200,
              ),
              child: Image.network(
                // Placeholder Image URL
                'https://placehold.co/600x400/CCCCCC/333333?text=FOTO+DOKUMENTASI',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text('Gagal memuat gambar', style: TextStyle(color: Colors.grey.shade600)),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
