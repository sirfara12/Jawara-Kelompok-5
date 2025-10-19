import 'package:flutter/material.dart';

class EditPesanWargaScreen extends StatefulWidget {
  final Map<String, String> pesan;

  const EditPesanWargaScreen({super.key, required this.pesan});

  @override
  State<EditPesanWargaScreen> createState() => _EditPesanWargaScreenState();
}

class _EditPesanWargaScreenState extends State<EditPesanWargaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  // Status yang BISA DIUBAH
  String? _selectedStatus;
  final List<String> _statusList = ['Pending', 'Diterima', 'Ditolak'];

  @override
  void initState() {
    super.initState();
    final Map<String, String> data = widget.pesan;

    _judulController.text = data['judul'] ?? '';
    _deskripsiController.text = data['deskripsi'] ?? '';

    if (_statusList.contains(data['status'])) {
      _selectedStatus = data['status'];
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  // Simpan Perubahan
  void _simpanPerubahan() {
    if (_formKey.currentState!.validate()) {
      final updatedPesan = Map<String, String>.from(widget.pesan);

      updatedPesan['status'] = _selectedStatus!;
      updatedPesan['id'] = widget.pesan['id']!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Status pesan "${updatedPesan['judul']}" berhasil diubah menjadi ${_selectedStatus!}',
          ),
        ),
      );
      Navigator.pop(context, updatedPesan);
    }
  }

  void _batalForm() {
    Navigator.pop(context);
  }

  // Widget input text field
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    int maxLines,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: true,
          style: TextStyle(color: Colors.grey.shade700),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Edit Informasi / Aspirasi Warga',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // JUDUL
              _buildTextField('Judul', _judulController, 1),

              // DESKRIPSI
              _buildTextField('Deskripsi', _deskripsiController, 5),

              // STATUS
              const Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items: _statusList.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Kolom Status wajib dipilih.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 48),

              // Tombol Batal dan Simpan
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Batal
                  ElevatedButton(
                    onPressed: _batalForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 12),
                  // Simpan
                  ElevatedButton(
                    onPressed: _simpanPerubahan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
