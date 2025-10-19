import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TambahChannelPage extends StatefulWidget {
  const TambahChannelPage({super.key});

  @override
  State<TambahChannelPage> createState() => _TambahChannelPageState();
}

class _TambahChannelPageState extends State<TambahChannelPage> {
  final Color primary = const Color(0xFF4E46B4);

  // Controllers
  final _namaChannelCtl = TextEditingController();
  final _nomorRekeningCtl = TextEditingController();
  final _namaPemilikCtl = TextEditingController();
  final _catatanCtl = TextEditingController();

  // Dropdown state
  String? _tipeChannel;

  @override
  void dispose() {
    _namaChannelCtl.dispose();
    _nomorRekeningCtl.dispose();
    _namaPemilikCtl.dispose();
    _catatanCtl.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _namaChannelCtl.clear();
      _nomorRekeningCtl.clear();
      _namaPemilikCtl.clear();
      _catatanCtl.clear();
      _tipeChannel = null;
    });
  }

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
          'Tambah Transfer Channel',
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
              // Nama Channel
              _buildTextField(
                label: 'Nama Channel',
                controller: _namaChannelCtl,
                hint: 'Contoh : BCA, Dana, Qris',
              ),
              const SizedBox(height: 16),

              // Tipe
              _buildDropdownField(
                label: 'Tipe',
                value: _tipeChannel,
                hint: 'Pilih tipe',
                items: const [
                  DropdownMenuItem(value: 'Bank', child: Text('Bank')),
                  DropdownMenuItem(value: 'E-Wallet', child: Text('E-Wallet')),
                  DropdownMenuItem(value: 'QRIS', child: Text('QRIS')),
                ],
                onChanged: (value) => setState(() => _tipeChannel = value),
              ),
              const SizedBox(height: 16),

              // Nomor Rekening / Akun
              _buildTextField(
                label: 'Nomor Rekening / Akun',
                controller: _nomorRekeningCtl,
                hint: 'Contoh : 1234567890',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Nama Pemilik
              _buildTextField(
                label: 'Nama Pemilik',
                controller: _namaPemilikCtl,
                hint: 'Contoh : John Doe',
              ),
              const SizedBox(height: 16),

              // Catatan
              _buildTextField(
                label: 'Catatan',
                controller: _catatanCtl,
                hint: 'Contoh : Transfer hanya dari bank yang sama',
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey.shade400),
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _reset,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Backend logic untuk menyimpan data
                        context.pop();
                      },
                      child: const Text(
                        'Simpan',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
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
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary, width: 1.5),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
