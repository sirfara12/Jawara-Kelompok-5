import 'package:flutter/material.dart';
import 'daftar_broadcast.dart'; 

class EditBroadcastScreen extends StatefulWidget {
  final KegiatanBroadcast initialBroadcastData;

  const EditBroadcastScreen({
    Key? key,
    required this.initialBroadcastData,
  }) : super(key: key);

  @override
  State<EditBroadcastScreen> createState() => _EditBroadcastScreenState();
}

class _EditBroadcastScreenState extends State<EditBroadcastScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialBroadcastData.judul);
    _contentController = TextEditingController(text: widget.initialBroadcastData.konten);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  //simpan
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final newTitle = _titleController.text;
      final newContent = _contentController.text;
      Navigator.pop(context, {
        'status': 'updated',
        'judul': newTitle,
        'konten': newContent,
      }); 
    }
  }
  
  // Batal
  void _batalForm() {
    Navigator.pop(context);
  }

  // Widget input text field
  Widget _buildTextField(
      String label, TextEditingController controller, String hint,
      {bool isRequired = true, int maxLines = 1}) {
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
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Kolom $label wajib diisi.';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Edit Broadcast', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Divider(height: 1, color: Colors.grey),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextField('Judul Broadcast', _titleController, 'Masukkan Judul Broadcast'),
              _buildTextField('Isi Broadcast', _contentController, 'Tuliskan isi pesan siaran di sini...', maxLines: 8),
             const SizedBox(height: 100),
              
              // Aksi btl simpan
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Tombol Batal
                  ElevatedButton(
                    onPressed: _batalForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Batal'),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Tombol Simpan
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 106, 63, 181), 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}