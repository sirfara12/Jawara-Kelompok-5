import 'package:flutter/material.dart';

class DetailPesanWargaScreen extends StatelessWidget {
  final Map<String, String> pesan;

  const DetailPesanWargaScreen({super.key, required this.pesan});

  // Widget menampilkan setiap field data
  Widget _buildDetailField(
      String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String judul = pesan['judul'] ?? 'Tidak Ada Judul';
    final String deskripsi = pesan['deskripsi'] ?? 'Tidak Ada Deskripsi';
    final String status = pesan['status'] ?? 'N/A';
    final String dibuatOleh = pesan['pengirim'] ?? 'N/A';
    final String tanggalDibuat = pesan['tanggalDibuat'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Informasi / Aspirasi Warga',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailField('Judul', judul),
            _buildDetailField('Deskripsi', deskripsi, maxLines: 5),
            _buildDetailField('Status', status),
            _buildDetailField('Dibuat Oleh', dibuatOleh),
            _buildDetailField('Tanggal Dibuat', tanggalDibuat),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}