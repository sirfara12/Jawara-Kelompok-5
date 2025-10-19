import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPenggunaScreen extends StatelessWidget {
  final Map<String, String> userData;

  const DetailPenggunaScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: const Text(
          'Detail Pengguna',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Satu Container untuk semua detail
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: userData['imageUrl'] != null
                              ? NetworkImage(userData['imageUrl']!)
                              : null,
                          child: userData['imageUrl'] == null
                              ? Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.grey.shade600,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        // Name and Role
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['name'] ?? 'Nama Tidak Tersedia',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                userData['role'] ?? 'Role Tidak Tersedia',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(userData['status']),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            userData['status'] ?? 'Aktif',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),

                    // Detail Information - Semua di dalam container yang sama
                    _buildDetailItem(
                      label: 'NIK',
                      value: userData['nik'] ?? '-',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildDetailItem(
                      label: 'Email',
                      value: userData['email'] ?? '-',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildDetailItem(
                      label: 'Nomor HP',
                      value: userData['phone'] ?? '-',
                    ),
                    const SizedBox(height: 16),
                    
                    _buildDetailItem(
                      label: 'Jenis Kelamin',
                      value: userData['gender'] ?? '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'aktif':
      case 'diterima':
        return const Color(0xFF34C759);
      case 'nonaktif':
      case 'ditolak':
        return Colors.red;
      case 'menunggu':
        return Colors.orange;
      default:
        return const Color(0xFF34C759);
    }
  }
}
