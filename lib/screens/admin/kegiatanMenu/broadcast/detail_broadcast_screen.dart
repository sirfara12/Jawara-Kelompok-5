import 'package:flutter/material.dart';
import 'daftar_broadcast.dart';

class DetailBroadcastScreen extends StatelessWidget {
  final KegiatanBroadcast broadcastData;

  const DetailBroadcastScreen({
    super.key,
    required this.broadcastData,
  });
  
  // Widget menampilkan Detail Info
  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
  
  // Widget  Detail Area
  Widget _buildDetailArea(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            value,
            style: const TextStyle(height: 1.5), 
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Widget dokumen PDF
  Widget _buildDocumentItem(String filename) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24),
            const SizedBox(width: 8),
            Text(filename),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Broadcast',
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
            _buildDetailField('Judul Broadcast', broadcastData.judul),
            _buildDetailArea('Isi Broadcast', broadcastData.konten),
            _buildDetailField('Tanggal Publikasi', broadcastData.tanggal),
            _buildDetailField('Dibuat oleh', broadcastData.pengirim),
            
            // Lampiran
            if (broadcastData.lampiranGambarUrl != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lampiran Gambar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      broadcastData.lampiranGambarUrl!,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              
            // Lampiran Dokumen
            if (broadcastData.lampiranDokumen.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lampiran Dokumen',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ...broadcastData.lampiranDokumen.map((doc) => _buildDocumentItem(doc)).toList(),
                  const SizedBox(height: 24),
                ],
              ),
          ],
        ),
      ),
    );
  }
}