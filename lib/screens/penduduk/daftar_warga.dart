import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DaftarWargaPage extends StatefulWidget {
  const DaftarWargaPage({super.key});

  @override
  State<DaftarWargaPage> createState() => _DaftarWargaPageState();
}

class _DaftarWargaPageState extends State<DaftarWargaPage> {
  final Color primary = const Color(0xFF4E46B4);
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _query = '';

  final List<Map<String, String>> _items = List.generate(8, (i) {
    return {
      'name': i % 2 == 0 ? 'Muhamad Rifda Musyaffa\'' : 'Gamers Sejati 18xX',
      'nik': (2300000000 + i).toString(),
      'family': ['Keluarga Besar Mojokerto', 'Keluarga Besar Blitar'][i % 2],
      'status': i % 3 == 0 ? 'Aktif' : 'Nonaktif',
      'life': i % 2 == 0 ? 'Hidup' : 'Wafat',
    };
  });

  void _openFilter() {
    String? gender;
    String? status;
    String? family;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (c) {
        final bottom = MediaQuery.of(c).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Filter Penerimaan Warga',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: gender,
                        isExpanded: true,
                        decoration: _dropdownDecoration(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: (v) => setModalState(() => gender = v),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        isExpanded: true,
                        decoration: _dropdownDecoration(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Aktif',
                            child: Text('Aktif'),
                          ),
                          DropdownMenuItem(
                            value: 'Nonaktif',
                            child: Text('Nonaktif'),
                          ),
                          DropdownMenuItem(
                            value: 'Wafat',
                            child: Text('Wafat'),
                          ),
                        ],
                        onChanged: (v) => setModalState(() => status = v),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Keluarga',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: family,
                        isExpanded: true,
                        decoration: _dropdownDecoration(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Keluarga Besar Mojokerto',
                            child: Text('Keluarga Besar Mojokerto'),
                          ),
                          DropdownMenuItem(
                            value: 'Keluarga Besar Blitar',
                            child: Text('Keluarga Besar Blitar'),
                          ),
                        ],
                        onChanged: (v) => setModalState(() => family = v),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(
                                  color: Color.fromRGBO(78, 70, 180, 0.12),
                                ),
                                backgroundColor: const Color(0xFFF4F3FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setModalState(() {
                                  gender = null;
                                  status = null;
                                  family = null;
                                });
                              },
                              child: const Text(
                                'Reset Filter',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4E46B4),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Terapkan',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        borderSide: const BorderSide(color: Color(0xFF4E46B4), width: 1.2),
      ),
    );
  }

  List<Map<String, String>> get _filtered {
    if (_query.isEmpty) return _items;
    return _items
        .where(
          (e) =>
              e['name']!.toLowerCase().contains(_query.toLowerCase()) ||
              e['nik']!.contains(_query),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
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
        title: Row(
          children: [
            // IconButton(
            //   onPressed: () => context.go('/admin/dashboard'),
            //   icon: const Icon(Icons.chevron_left, color: Colors.black),
            // ),
            const SizedBox(width: 8),
            const Text(
              'Daftar Warga',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation pills
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _TopNavItem(
                            label: 'Penduduk',
                            active: true,
                            primary: primary,
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _TopNavItem(
                            label: 'Rumah',
                            active: false,
                            primary: primary,
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _TopNavItem(
                            label: 'Keluarga',
                            active: false,
                            primary: primary,
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _TopNavItem(
                            label: 'Penerimaan',
                            active: false,
                            primary: primary,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search and filter
            _SearchFilterBar(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (v) => setState(() => _query = v),
              onFilterTap: _openFilter,
            ),

            // list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 80, top: 8),
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _filtered[index];
                    return _WargaCard(
                      item: item,
                      primary: primary,
                      onTap: () =>
                          context.pushNamed('wargaDetail', extra: item),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () => context.pushNamed('wargaAdd'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  const _SearchFilterBar({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: onChanged,
                onTap: () => focusNode.requestFocus(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  hintText: 'Search Name or NIK',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onFilterTap,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.tune, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopNavItem extends StatelessWidget {
  final String label;
  final bool active;
  final Color primary;
  final VoidCallback onTap;

  const _TopNavItem({
    required this.label,
    required this.active,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? const Color.fromRGBO(78, 70, 180, 0.12)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: active ? Border.all(color: primary) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: active ? primary : Colors.black87,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (active) ...[
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 8, color: Color(0xFF4E46B4)),
            ],
          ],
        ),
      ),
    );
  }
}

class _WargaCard extends StatelessWidget {
  final Map<String, String> item;
  final Color primary;
  final VoidCallback? onTap;

  const _WargaCard({required this.item, required this.primary, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 8),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'NIK : ${item['nik']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Builder(
                        builder: (context) {
                          final c = Colors.black;
                          return Text(
                            'Keluarga : ${item['family']}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: c.withValues(alpha: 0.8)),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _StatusChip(status: item['status'] ?? 'Nonaktif'),
                          _LifeChip(life: item['life'] ?? 'Hidup'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(78, 70, 180, 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.chevron_right, color: primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text = Colors.white;
    switch (status.toLowerCase()) {
      case 'aktif':
        bg = Colors.green;
        break;
      default:
        bg = Colors.grey.shade300;
        text = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.map, size: 14, color: text),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LifeChip extends StatelessWidget {
  final String life;
  const _LifeChip({required this.life});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text = Colors.white;
    switch (life.toLowerCase()) {
      case 'hidup':
        bg = Colors.green;
        break;
      default:
        bg = Colors.grey.shade300;
        text = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person, size: 14, color: text),
          const SizedBox(width: 6),
          Text(
            life,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
