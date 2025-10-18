import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/widget/moon_result_modal.dart';
import 'package:moon_design/moon_design.dart';

class DetailWargaPage extends StatelessWidget {
  final Map<String, String> warga;
  const DetailWargaPage({super.key, required this.warga});

  Color get primary => const Color(0xFF4E46B4);

  @override
  Widget build(BuildContext context) {
    final name = warga['name'] ?? '-';
    final nik = warga['nik'] ?? '-';
    final keluarga = warga['family'] ?? '-';
    final status = warga['status'] ?? 'Aktif';

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: Text(
          'Detail Warga',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          _MoreMenu(
            wargaName: name,
            onEdit: () {
              context.pushNamed('wargaEdit', extra: warga);
            },
            onDeleteConfirmed: () async {
              final confirmed = await _showDeleteConfirmationDialog(
                context: context,
                title: 'Hapus Data Warga?',
                message:
                    'Apakah Anda yakin ingin menghapus data "$name"? Data yang sudah dihapus tidak dapat dikembalikan.',
              );
              if (confirmed == true) {
                // TODO: Panggil service penghapusan data di sini
                await showResultModal(
                  context,
                  type: ResultType.success,
                  title: 'Berhasil',
                  description: 'Data "$name" telah dihapus.',
                  actionLabel: 'Selesai',
                  autoProceed: true,
                );
                // Kembali ke halaman daftar warga
                if (context.mounted) Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),

      body: Container(
        color: const Color(0xFFF7F7FB),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            // Header info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'NIK :  $nik',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Data Diri',
              children: const [
                _IconTextRow(
                  icon: Icons.event,
                  title: 'Tempat, Tanggal Lahir:',
                  value: 'Mojokerto, 11 Januari 2004',
                ),
                _IconTextRow(
                  icon: Icons.people,
                  title: 'Jenis Kelamin:',
                  value: 'Laki - Laki',
                ),
                _IconTextRow(
                  icon: Icons.self_improvement,
                  title: 'Agama:',
                  value: 'Islam',
                ),
                _IconTextRow(
                  icon: Icons.bloodtype,
                  title: 'Golongan Darah:',
                  value: 'O',
                ),
              ],
            ),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Keluarga & Kependudukan',
              children: [
                _IconTextRow(
                  icon: Icons.groups_2,
                  title: 'Keluarga:',
                  value: keluarga,
                ),
                const _IconTextRow(
                  icon: Icons.badge,
                  title: 'Peran Dalam Keluarga:',
                  value: 'Anak',
                ),
                _IconTextRow(
                  icon: Icons.verified,
                  title: 'Status Kependudukan:',
                  value: status,
                ),
              ],
            ),

            const SizedBox(height: 16),

            const _SectionCard(
              title: 'Informasi Tambahan',
              children: [
                _IconTextRow(
                  icon: Icons.school,
                  title: 'Pendidikan Terakhir:',
                  value: 'Sekolah Menengah Atas',
                ),
                _IconTextRow(
                  icon: Icons.work_outline,
                  title: 'Pekerjaan:',
                  value: 'Data Engineer',
                ),
                _IconTextRow(
                  icon: Icons.phone,
                  title: 'Nomor Telephone:',
                  value: '081234567890',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ========================= More Menu & Dialog =========================

enum _MoreMenuAction { edit, delete }

class _MoreMenu extends StatelessWidget {
  final String wargaName;
  final VoidCallback onEdit;
  final Future<void> Function() onDeleteConfirmed;

  const _MoreMenu({
    required this.wargaName,
    required this.onEdit,
    required this.onDeleteConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MoreMenuAction>(
      tooltip: 'Lainnya',
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (value) async {
        switch (value) {
          case _MoreMenuAction.edit:
            onEdit();
            break;
          case _MoreMenuAction.delete:
            await onDeleteConfirmed();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _MoreMenuAction.edit,
          child: ListTile(
            dense: true,
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem(
          value: _MoreMenuAction.delete,
          child: ListTile(
            dense: true,
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}

Future<bool?> _showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  bool? result;
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'DeleteConfirm',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (ctx, anim, secAnim) {
      final colors = ctx.moonColors ?? MoonTokens.light.colors;
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: MediaQuery.of(ctx).size.width * 0.86,
            constraints: const BoxConstraints(maxWidth: 440),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: MoonSquircleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ).squircleBorderRadius(ctx),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 12),
                Text(title, style: MoonTokens.light.typography.heading.text18),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: MoonTokens.light.typography.body.text14.copyWith(
                    color: colors.trunks,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: MoonOutlinedButton(
                        onTap: () {
                          result = false;
                          Navigator.of(ctx).maybePop();
                        },
                        label: const Text('Tutup'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MoonFilledButton(
                        backgroundColor: Colors.red,
                        onTap: () {
                          result = true;
                          Navigator.of(ctx).maybePop();
                        },
                        label: const Text('Ya, Hapus'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (ctx, anim, secAnim, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      final slide = Tween<Offset>(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).animate(curved);
      final fade = Tween<double>(begin: 0.8, end: 1).animate(curved);
      return SlideTransition(
        position: slide,
        child: FadeTransition(opacity: fade, child: child),
      );
    },
  );
  return result;
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            ...children.map(
              (w) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTextRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _IconTextRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(78, 70, 180, 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF4E46B4)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}
