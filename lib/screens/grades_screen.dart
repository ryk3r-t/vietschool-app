import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../services/ota_sync_service.dart';

/// Data model for a subject grade row.
class _SubjectGrade {
  final String name;
  final String dgtx;  // ĐGTX 1
  final String dgtx2; // ĐGTX 2
  final String dggk;  // ĐGGK 1
  final String dtb;   // ĐTB

  const _SubjectGrade(this.name, this.dgtx, this.dggk, this.dtb, {this.dgtx2 = ''});
}

/// "Điểm" (Grades) screen – matches the provided screenshots exactly.
/// Dynamically updates from OTA cached grades.json if available.
class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  static const Color _primary = Color(0xFF45B0A8);
  static const Color _bgGrey = Color(0xFFF4F6F8);

  String _studentName = 'T.N.M.QUÂN';
  String _academicYear = '2026-2027';
  String _term = 'ĐỢT 1(05/08-11/10)';
  String _kqht = 'Tốt';
  String _kqrl = '-';
  String _teacherComment = '-';

  static const List<String> _termOptions = [
    'ĐỢT 1(05/08-11/10)',
    'ĐỢT 2(12/10-16/11)',
    'Đợt 3(17/11-21/12)',
    'Đợt 4(22/12-28/12)',
    'Học kỳ 1',
    'Đợt 1(01/01/2/2026)',
    'Đợt 2(09/02-29/3)',
    'Đợt 3(30/3-19/04/2026)',
    'Đợt 4(20/04_10/05/2026',
    'Học kỳ 2',
    'Cả năm',
  ];

  void _showTermSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.88,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF7F8FA),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Modal Title
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: const [
                    Text(
                      'Chọn đợt điểm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Options List
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _termOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = _termOptions[index];
                    final isSelected = item == _term;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _term = item;
                          if (item == 'ĐỢT 1(05/08-11/10)') {
                            _kqht = 'Tốt';
                            _kqrl = '-';
                            _teacherComment = '-';
                            _grades = _gradesTerm1;
                            _barData = _barDataTerm1;
                          } else if (item == 'ĐỢT 2(12/10-16/11)') {
                            _kqht = '-';
                            _kqrl = '-';
                            _teacherComment = '-';
                            _grades = _gradesTerm2;
                            _barData = const [];
                          } else if (item == 'Học kỳ 1') {
                            _kqht = '-';
                            _kqrl = '-';
                            _teacherComment = '-';
                            _grades = _gradesHk1;
                            _barData = const [];
                          } else {
                            _kqht = '-';
                            _kqrl = '-';
                            _teacherComment = '-';
                            _grades = _gradesEmpty;
                            _barData = const [];
                          }
                        });
                        Navigator.pop(ctx);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF38A3A5)
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom "ĐÓNG" Button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF0F766E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'ĐÓNG',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F766E),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static const List<_SubjectGrade> _gradesTerm1 = [
    _SubjectGrade('Toán',     '7.0', '', '7.0'),
    _SubjectGrade('Vật lí',   '8.5', '', '8.5'),
    _SubjectGrade('Hóa học',  '',    '', ''),
    _SubjectGrade('Sinh học', '',    '', ''),
    _SubjectGrade('Tin học',  '10',  '', '10'),
    _SubjectGrade('Ngữ văn', '9.0', '', '9.0'),
    _SubjectGrade('Lịch Sử', '8.0', '', '8.0'),
    _SubjectGrade('Địa Lí',  '10',  '', ''),
    _SubjectGrade('Ngoại ngữ', '8.3', '', '8.3'),
    _SubjectGrade('TNHN',    'Đ',   '', 'Đ'),
    _SubjectGrade('Tiếng dân tộc thiểu số', '', '', ''),
    _SubjectGrade('GDTC',    'Đ',   '', 'Đ'),
    _SubjectGrade('GĐĐP',    'Đ',   '', 'Đ'),
    _SubjectGrade('GDKTPL',  '9.5', '', '9.5'),
    _SubjectGrade('GDQP',    '9.0', '', '9.0'),
    _SubjectGrade('Âm nhạc', '',    '', ''),
  ];

  static const List<_SubjectGrade> _gradesTerm2 = [
    _SubjectGrade('Toán',     '8.0', '5.8', ''),
    _SubjectGrade('Vật lí',   '10',  '8.0', ''),
    _SubjectGrade('Tin học',  '',    '10',  ''),
    _SubjectGrade('Ngữ văn', '9.5', '7.3', ''),
    _SubjectGrade('Lịch Sử', '',    '7.3', ''),
    _SubjectGrade('Địa Lí',  '',    '8.3', ''),
    _SubjectGrade('Ngoại ngữ', '',    '8.6', ''),
    _SubjectGrade('TNHN',    '',    'Đ',   ''),
    _SubjectGrade('Tiếng dân tộc thiểu số', '', '', ''),
    _SubjectGrade('GDTC',    '',    'Đ',   ''),
    _SubjectGrade('GĐĐP',    '',    'Đ',   ''),
    _SubjectGrade('GDKTPL',  '',    '8.3', ''),
    _SubjectGrade('GDQP',    '9.5', '',    ''),
  ];

  static const List<_SubjectGrade> _gradesHk1 = [
    _SubjectGrade('Toán',     '7.0', '5.8', '', dgtx2: '8.0'),
    _SubjectGrade('Vật lí',   '8.5', '8.0', '', dgtx2: '10'),
    _SubjectGrade('Tin học',  '10',  '10',  ''),
    _SubjectGrade('Ngữ văn', '9.0', '7.3', '', dgtx2: '9.5'),
    _SubjectGrade('Lịch Sử', '8.0', '7.3', ''),
    _SubjectGrade('Địa Lí',  '10',  '8.3', ''),
    _SubjectGrade('Ngoại ngữ', '8.3', '8.6', ''),
    _SubjectGrade('TNHN',    'Đ',   'Đ',   ''),
    _SubjectGrade('Tiếng dân tộc thiểu số', '', '', ''),
    _SubjectGrade('GDTC',    'Đ',   'Đ',   ''),
    _SubjectGrade('GDĐP',    'Đ',   'Đ',   ''),
    _SubjectGrade('GDKTPL',  '9.5', '8.3', ''),
    _SubjectGrade('GDQP',    '9.0', '',    '', dgtx2: '9.5'),
  ];

  static const List<_SubjectGrade> _gradesEmpty = [
    _SubjectGrade('Toán',     '', '', ''),
    _SubjectGrade('Vật lí',   '', '', ''),
    _SubjectGrade('Hóa học',  '', '', ''),
    _SubjectGrade('Sinh học', '', '', ''),
    _SubjectGrade('Tin học',  '', '', ''),
    _SubjectGrade('Ngữ văn', '', '', ''),
    _SubjectGrade('Lịch Sử', '', '', ''),
    _SubjectGrade('Địa Lí',  '', '', ''),
    _SubjectGrade('Ngoại ngữ', '', '', ''),
    _SubjectGrade('TNHN',    '', '', ''),
    _SubjectGrade('Tiếng dân tộc thiểu số', '', '', ''),
    _SubjectGrade('GDTC',    '', '', ''),
    _SubjectGrade('GĐĐP',    '', '', ''),
    _SubjectGrade('GDKTPL',  '', '', ''),
    _SubjectGrade('GDQP',    '', '', ''),
    _SubjectGrade('Âm nhạc', '', '', ''),
  ];

  static const List<_BarData> _barDataTerm1 = [
    _BarData('Toán',      7.0,  false),
    _BarData('Vật lí',    8.5,  false),
    _BarData('Tin học',   10.0, false),
    _BarData('Ngữ văn',  9.0,  false),
    _BarData('Lịch Sử',  8.0,  false),
    _BarData('Ngoại ngữ',8.3,  false),
    _BarData('TNHN',      0,   true),
    _BarData('GDTC',      0,   true),
    _BarData('GĐĐP',      0,   true),
    _BarData('GDKTPL',   9.5,  false),
    _BarData('GDQP',     9.0,  false),
  ];

  List<_SubjectGrade> _grades = _gradesTerm1;
  List<_BarData> _barData = _barDataTerm1;

  @override
  void initState() {
    super.initState();
    _loadOtaGrades();
  }

  Future<void> _loadOtaGrades() async {
    final cached = await OtaSyncService.getLocalJson('grades.json');
    if (cached != null && mounted) {
      setState(() {
        if (cached['studentName'] != null) _studentName = cached['studentName'];
        if (cached['academicYear'] != null) _academicYear = cached['academicYear'];
        if (cached['term'] != null) _term = cached['term'];
        if (cached['kqht'] != null) _kqht = cached['kqht'];
        if (cached['kqrl'] != null) _kqrl = cached['kqrl'];
        if (cached['teacherComment'] != null) _teacherComment = cached['teacherComment'];

        if (cached['subjects'] is List) {
          final list = (cached['subjects'] as List).map((s) {
            return _SubjectGrade(
              s['name'] ?? '',
              s['dgtx'] ?? '',
              s['dggk'] ?? '',
              s['dtb'] ?? '',
            );
          }).toList();
          if (list.isNotEmpty) {
            _grades = list;
            _barData = list.where((s) => s.dtb.isNotEmpty).map((s) {
              final isDat = s.dtb == 'Đ';
              final val = double.tryParse(s.dtb) ?? 0.0;
              return _BarData(s.name, val, isDat);
            }).toList();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Text(
          'Điểm - $_studentName',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // ─── Dropdown selectors ───
          Container(
            color: _primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(child: _DropdownBtn(title: 'Niên học', value: _academicYear)),
                const SizedBox(width: 12),
                Expanded(
                  child: _DropdownBtn(
                    title: 'Đợt điểm',
                    value: _term,
                    onTap: _showTermSelectionModal,
                  ),
                ),
              ],
            ),
          ),

          // ─── Scrollable body ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                // ── KQHT / KQRL cards ──
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        label: 'KQHT',
                        value: _kqht,
                        icon: Icons.school,
                        iconColor: const Color(0xFF5D9CEC),
                        iconBg: const Color(0xFFE5F0FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        label: 'KQRL',
                        value: _kqrl,
                        icon: Icons.workspace_premium,
                        iconColor: const Color(0xFFF08A24),
                        iconBg: const Color(0xFFFFF0E6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Teacher comment card ──
                _WhiteCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE0F7FA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.chat_bubble_outline, color: _primary, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Text('Nhận xét của GVCN',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(_teacherComment, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Bar chart: Điểm TB từng môn ──
                _WhiteCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Điểm TB từng môn',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Text('Xem thêm',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                                Icon(Icons.chevron_right, color: Colors.grey.shade500, size: 18),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _barData.isEmpty
                            ? Container(
                                height: 160,
                                alignment: Alignment.center,
                                child: const Text(
                                  'No chart data available.',
                                  style: TextStyle(color: Color(0xFFE5A93C), fontSize: 14),
                                ),
                              )
                            : SizedBox(
                                height: 200,
                                child: _BarChart(data: _barData),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Donut chart: Phân bổ kết quả ──
                _WhiteCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Phân bổ kết quả',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _barData.isEmpty
                            ? Container(
                                height: 160,
                                alignment: Alignment.center,
                                child: const Text(
                                  'No chart data available.',
                                  style: TextStyle(color: Color(0xFFE5A93C), fontSize: 14),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        height: 130,
                                        child: CustomPaint(
                                          painter: _DonutPainter(),
                                          child: const Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('16',
                                                    style: TextStyle(
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xFF333333))),
                                                Text('Môn',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF666666))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      // Legend
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            _LegendRow(
                                                color: Color(0xFF66CDAA),
                                                label: 'Giỏi',
                                                count: '7 môn'),
                                            SizedBox(height: 12),
                                            _LegendRow(
                                                color: Color(0xFF3B82F6),
                                                label: 'Khá',
                                                count: '1 môn'),
                                            SizedBox(height: 12),
                                            _LegendRow(
                                                color: Color(0xFF7DD3E8),
                                                label: 'Đ',
                                                count: '3 môn'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(Icons.info_outline,
                                          color: Colors.grey.shade400, size: 16),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Chạm vào vùng trên biểu đồ hoặc chú thích để lọc, chạm lại để bỏ lọc.',
                                          style: TextStyle(
                                              color: Colors.grey.shade500, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Table header row with toggle icons ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Điểm chi tiết từng môn',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Icon(Icons.format_list_bulleted_rounded,
                                color: Colors.grey.shade500, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Grades table ──
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _GradesTable(grades: _grades, showDgtx2: _term == 'Học kỳ 1'),
                ),
                const SizedBox(height: 16),

                // ── Note box ──
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.error_outline_rounded, color: Color(0xFF0369A1), size: 20),
                          SizedBox(width: 8),
                          Text('Lưu ý',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0369A1))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Vị trí dấu 'x' là thông tin chưa được công bố. Chi tiết liên hệ nhà trường.",
                        style: TextStyle(fontSize: 14, color: Color(0xFF334155), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Reusable small widgets
// ─────────────────────────────────────────────

class _DropdownBtn extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;
  const _DropdownBtn({required this.title, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                const Icon(Icons.arrow_drop_down_rounded, color: Colors.white, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  const _InfoCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.iconColor,
      required this.iconBg});

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final Widget child;
  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final String count;
  const _LegendRow({required this.color, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 15, color: Color(0xFF555555))),
        ),
        Text(count,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Bar chart (custom painted)
// ─────────────────────────────────────────────

class _BarData {
  final String label;
  final double value;
  final bool isDat; // true if the score is "Đ" (not numeric)
  const _BarData(this.label, this.value, this.isDat);
}

class _BarChart extends StatelessWidget {
  final List<_BarData> data;
  const _BarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    const double maxVal = 10.0;
    const double barAreaHeight = 150; // height reserved for bars
    const double labelAreaHeight = 50; // height reserved for bottom labels

    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;
      final barWidth = (totalWidth / data.length) * 0.5;
      final spacing = (totalWidth - barWidth * data.length) / (data.length + 1);

      return SizedBox(
        height: barAreaHeight + labelAreaHeight,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // bars
            ...List.generate(data.length, (i) {
              final d = data[i];
              final barH = d.isDat ? 30.0 : (d.value / maxVal) * barAreaHeight;
              final left = spacing + i * (barWidth + spacing);
              final isFirst = i == 0;
              // First bar is darker blue, rest are teal
              final barColor = isFirst ? const Color(0xFF3B82B0) : const Color(0xFF5EC4C0);

              return Positioned(
                left: left,
                bottom: labelAreaHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // value label above bar
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        d.isDat ? 'Đ' : _formatScore(d.value),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    // the bar
                    Container(
                      width: barWidth,
                      height: barH,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              );
            }),
            // bottom labels
            ...List.generate(data.length, (i) {
              final d = data[i];
              final left = spacing + i * (barWidth + spacing);
              return Positioned(
                left: left - 4,
                bottom: 0,
                child: SizedBox(
                  width: barWidth + 8,
                  height: labelAreaHeight,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        d.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  static String _formatScore(double v) {
    if (v == v.roundToDouble() && v == v.toInt().toDouble()) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }
}

// ─────────────────────────────────────────────
//  Donut chart (custom painted)
// ─────────────────────────────────────────────

class _DonutPainter extends CustomPainter {
  // Giỏi: 7, Khá: 1, Đ: 3, rest (no score): 5
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 22.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    const total = 16;
    const gioi = 7;
    const kha = 1;
    const dat = 3;
    const noScore = 5;

    final segments = <_DonutSegment>[
      _DonutSegment(gioi / total, const Color(0xFF66CDAA)),
      _DonutSegment(kha / total, const Color(0xFF3B82F6)),
      _DonutSegment(dat / total, const Color(0xFF7DD3E8)),
      _DonutSegment(noScore / total, const Color(0xFFE5E7EB)),
    ];

    double startAngle = -math.pi / 2;
    for (final seg in segments) {
      final sweep = seg.fraction * 2 * math.pi;
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutSegment {
  final double fraction;
  final Color color;
  const _DonutSegment(this.fraction, this.color);
}

// ─────────────────────────────────────────────
//  Grades table
// ─────────────────────────────────────────────

class _GradesTable extends StatelessWidget {
  final List<_SubjectGrade> grades;
  final bool showDgtx2;
  const _GradesTable({required this.grades, this.showDgtx2 = false});

  static const Color _hdrBg = Color(0xFFF4FAFB);
  static const Color _hdrText = Color(0xFF0F766E);
  static const Color _tealDtb = Color(0xFF0F766E);

  @override
  Widget build(BuildContext context) {
    final double ttW = showDgtx2 ? 36 : 40;
    final double dgtxW = showDgtx2 ? 44 : 54;
    final double dggkW = showDgtx2 ? 48 : 54;
    final double dtbW = showDgtx2 ? 48 : 60;

    return Column(
      children: [
        // ── Header row (2 lines) ──
        Container(
          color: _hdrBg,
          child: Row(
            children: [
              // TT – spans 2 lines
              _hCell('TT', width: ttW, height: 56),
              // Môn – spans 2 lines
              Expanded(child: _hCell('Môn', height: 56)),
              // ĐGTX with sub "1" (and "2" when showDgtx2)
              if (showDgtx2)
                Column(
                  children: [
                    _hCell('ĐGTX', width: dgtxW * 2, height: 28, borderBottom: false),
                    Row(
                      children: [
                        _hCell('1', width: dgtxW, height: 28),
                        _hCell('2', width: dgtxW, height: 28),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _hCell('ĐGTX', width: dgtxW, height: 28, borderBottom: false),
                    _hCell('1', width: dgtxW, height: 28),
                  ],
                ),
              // ĐGGK with sub "1"
              Column(
                children: [
                  _hCell('ĐGGK', width: dggkW, height: 28, borderBottom: false),
                  _hCell('1', width: dggkW, height: 28),
                ],
              ),
              // ĐTB – spans 2 lines
              _hCell('ĐTB', width: dtbW, height: 56),
            ],
          ),
        ),
        // ── Data rows ──
        ...List.generate(grades.length, (i) {
          final g = grades[i];
          final bgColor = i.isOdd ? const Color(0xFFF9FAFB) : Colors.white;
          return Container(
            color: bgColor,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _dCell('${i + 1}', width: ttW),
                  Expanded(child: _dCell(g.name, bold: true, alignLeft: true)),
                  _dCell(g.dgtx, width: dgtxW),
                  if (showDgtx2) _dCell(g.dgtx2, width: dgtxW),
                  _dCell(g.dggk, width: dggkW),
                  _dCell(g.dtb, width: dtbW, isTeal: g.dtb.isNotEmpty),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  /// Header cell
  Widget _hCell(String text, {double? width, required double height, bool borderBottom = true}) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
          bottom: borderBottom ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
        ),
      ),
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: _hdrText, fontSize: 13, fontWeight: FontWeight.bold)),
    );
  }

  /// Data cell
  Widget _dCell(String text,
      {double? width, bool bold = false, bool alignLeft = false, bool isTeal = false}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
          vertical: 14, horizontal: alignLeft ? 12 : 6),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
      child: Text(
        text,
        textAlign: alignLeft ? TextAlign.left : TextAlign.center,
        style: TextStyle(
          color: isTeal ? _tealDtb : const Color(0xFF374151),
          fontSize: 14,
          fontWeight: bold || isTeal ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}