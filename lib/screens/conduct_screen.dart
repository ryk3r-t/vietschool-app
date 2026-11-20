import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common.dart';

/// "Hạnh kiểm" (conduct) screen – opened from Chức năng › Học tập.
class ConductScreen extends StatefulWidget {
  const ConductScreen({super.key});
  @override
  State<ConductScreen> createState() => _ConductScreenState();
}

class _Record {
  final DateTime date;
  final String title;
  final String? note;
  const _Record(this.date, this.title, [this.note]);
}

final _records = [
  _Record(DateTime(2026, 9, 24), 'Nghỉ học có phép buổi chiều'),
  _Record(DateTime(2026, 9, 21), 'Nghỉ học có phép buổi sáng', 'sổ mũi, sốt'),
  _Record(DateTime(2026, 9, 14), 'Nghỉ học có phép buổi sáng', 'Đau bụng, sốt'),
];

String _two(int n) => n.toString().padLeft(2, '0');
String _fmt(DateTime d) => '${_two(d.day)}/${_two(d.month)}/${d.year}';
String _weekday(DateTime d) => d.weekday == DateTime.sunday ? 'Chủ nhật' : 'Thứ ${d.weekday + 1}';

const _textDark = Color(0xFF2B3440);
const _textGrey = Color(0xFF6B7280);
const _border = Color(0xFFDDE3EA);

class _ConductScreenState extends State<ConductScreen> {
  DateTime? _from;
  DateTime? _to;
  String _query = '';

  List<_Record> get _filtered => _records.where((r) {
        if (_from != null && r.date.isBefore(_from!)) return false;
        if (_to != null && r.date.isAfter(_to!)) return false;
        if (_query.isNotEmpty) {
          final q = _query.toLowerCase();
          final hay = '${r.title} ${r.note ?? ''}'.toLowerCase();
          if (!hay.contains(q)) return false;
        }
        return true;
      }).toList();

  Future<void> _pickDate(bool isFrom) async {
    final current = isFrom ? _from : _to;
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime(2026, 9, 24),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    // Cancelling the picker clears the filter back to "Tất cả".
    setState(() => isFrom ? _from = picked : _to = picked);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: kBgTeal,
        body: Column(children: [
          // App bar
          Container(
            color: kTeal,
            padding: EdgeInsets.fromLTRB(8, MediaQuery.of(context).padding.top + 8, 16, 10),
            child: Row(children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text('Hạnh kiểm - T.N.M.QUÂN',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(18, 18, 18, 24), children: [
              // Filter card
              _Card(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: _DateField(label: 'Từ ngày', value: _from, onTap: () => _pickDate(true))),
                    const SizedBox(width: 12),
                    Expanded(child: _DateField(label: 'Đến ngày', value: _to, onTap: () => _pickDate(false))),
                  ]),
                  const SizedBox(height: 16),
                  const Text('Tìm kiếm', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _textDark)),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (v) => setState(() => _query = v.trim()),
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Tìm theo nội dung vi phạm...',
                      hintStyle: const TextStyle(color: Color(0xFFA9B0BA), fontSize: 15),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: _border, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: kTeal, width: 1.5),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              // Records card
              _Card(
                padding: EdgeInsets.zero,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                    child: Row(children: [
                      const Expanded(
                        child: Text('Danh sách ghi nhận',
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600, color: _textDark)),
                      ),
                      Text('${items.length} ghi nhận', style: const TextStyle(fontSize: 15, color: _textGrey)),
                    ]),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEF0F3)),
                  const SizedBox(height: 16),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text('Không có ghi nhận', textAlign: TextAlign.center, style: TextStyle(color: _textGrey)),
                    ),
                  ...items.map((r) => _TimelineItem(record: r)),
                  const SizedBox(height: 18),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _Card({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: child,
      );
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  const _DateField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _textDark)),
      const SizedBox(height: 8),
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _border, width: 1.5),
          ),
          child: Text(value == null ? 'Tất cả' : _fmt(value!),
              style: const TextStyle(fontSize: 15, color: Color(0xFF4B5563))),
        ),
      ),
    ]);
  }
}

class _TimelineItem extends StatelessWidget {
  final _Record record;
  const _TimelineItem({required this.record});

  @override
  Widget build(BuildContext context) {
    final sub = record.note == null ? _fmt(record.date) : '${_fmt(record.date)} · ${record.note}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Timeline dot + line
          SizedBox(
            width: 22,
            child: Column(children: [
              const SizedBox(height: 18),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: Color(0xFFDDF1F4), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: Color(0xFF3FB4C2), shape: BoxShape.circle),
                ),
              ),
              Expanded(child: Container(width: 2, color: const Color(0xFFDDE7EE))),
            ]),
          ),
          const SizedBox(width: 16),
          // Record card
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E9EF), width: 1.5),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Container(
                  color: const Color(0xFFEAF1FE),
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Text('${_weekday(record.date)} - ${_fmt(record.date)}',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: _textDark)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(record.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: _textDark)),
                    const SizedBox(height: 6),
                    Text(sub, style: const TextStyle(fontSize: 14, color: _textGrey)),
                  ]),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
