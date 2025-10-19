import 'package:flutter/material.dart';
import 'package:jawara_pintar_kel_5/models/iuran_model.dart';
import 'package:jawara_pintar_kel_5/screens/admin/layout.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/detail_iuran_screen.dart';
import 'package:jawara_pintar_kel_5/screens/admin/pemasukan/edit_iuran_screen.dart';

class KategoriIuranScreen extends StatefulWidget {
  const KategoriIuranScreen({super.key});

  @override
  State<KategoriIuranScreen> createState() => _KategoriIuranScreenState();
}

class _KategoriIuranScreenState extends State<KategoriIuranScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<IuranModel> _iuranList = [];
  List<IuranModel> _filteredIuranList = [];

  @override
  void initState() {
    super.initState();
    _iuranList = IuranModel.getSampleData();
    _filteredIuranList = _iuranList;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterIuran(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredIuranList = _iuranList;
      } else {
        _filteredIuranList = _iuranList
            .where(
              (iuran) =>
                  iuran.namaIuran.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      activeIndex: 2,
      showBottomNav: true,
      showBackButton: true,
      title: 'Kategori Iuran',
      body: Stack(
        children: [
          Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterIuran,
                        decoration: InputDecoration(
                          hintText: 'Search Name',
                          prefixIcon: const Icon(Icons.search, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // List Content
              Expanded(
                child: _filteredIuranList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tidak ada data',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredIuranList.length,
                        itemBuilder: (context, index) {
                          final iuran = _filteredIuranList[index];
                          return _buildIuranCard(iuran);
                        },
                      ),
              ),
            ],
          ),
          // Floating Action Button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {
                _showAddIuranDialog();
              },
              backgroundColor: const Color(0xFF6366F1),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIuranCard(IuranModel iuran) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            iuran.namaIuran,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                iuran.jenisIuran,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const Spacer(),
              Text(
                'Rp ${_formatCurrency(iuran.nominal)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailIuranScreen(iuran: iuran),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Detail'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditIuranScreen(iuran: iuran),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  void _showAddIuranDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Kategori Iuran'),
        content: const Text(
          'Fitur tambah kategori iuran akan segera tersedia.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
