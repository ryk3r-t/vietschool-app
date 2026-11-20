import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF45B0A8); // Màu xanh chủ đạo của Header/AppBar
    
    // Dữ liệu mẫu dựa trên hình ảnh
    final List<String> days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

    final List<List<String>> morningData = [
      ['', 'Vật lí', 'Ngoại ngữ', 'Ngữ văn', 'Tin học', ''],
      ['', 'Tin học', 'Lịch Sử', 'Ngữ văn', 'Ngữ văn', ''],
      ['Tự học Toán', 'Lịch Sử', 'Toán', 'Toán', 'Vật lí', ''],
      ['Tự học Toán', 'GDQP', 'Toán', 'Toán', 'Vật lí', ''],
      ['', '', '', '', '', ''],
    ];

    final List<List<String>> afternoonData = [
      ['Địa Lí', '', '', 'Ngoại ngữ', '', ''],
      ['Địa Lí', '', '', 'Ngoại ngữ', '', ''],
      ['GDKTPL', 'Ngữ văn', '', 'GDTC', '', ''],
      ['GDKTPL', 'Tự học Ngữ văn', '', 'GDTC', '', ''],
      ['', '', '', '', '', ''],
    ];

    // Cấu hình kích thước ô
    const double bWidth = 24.0;
    const double tWidth = 28.0;
    const double dayWidth = 100.0;
    const double cellHeight = 45.0;
    const double headerHeight = 50.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('TKB - T.N.M.QUÂN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: const Icon(Icons.fit_screen_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // Khung viền ngoài cùng bên trái và bên trên để tạo lưới 1px hoàn hảo
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 1),
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === CỘT TRÁI CỐ ĐỊNH (B & T) ===
                Row(
                  children: [
                    // Cột B (Buổi)
                    Column(
                      children: [
                        _buildCell('B', width: bWidth, height: headerHeight, bgColor: primaryColor, textColor: Colors.white, isBold: true),
                        _buildCell('S', width: bWidth, height: cellHeight * 5),
                        _buildCell('C', width: bWidth, height: cellHeight * 5),
                      ],
                    ),
                    // Cột T (Tiết)
                    Column(
                      children: [
                        _buildCell('T', width: tWidth, height: headerHeight, bgColor: primaryColor, textColor: Colors.white, isBold: true),
                        ...List.generate(5, (i) => _buildCell('${i + 1}', width: tWidth, height: cellHeight, isBold: true)),
                        ...List.generate(5, (i) => _buildCell('${i + 1}', width: tWidth, height: cellHeight, isBold: true)),
                      ],
                    ),
                  ],
                ),

                // === CỘT PHẢI CÓ THỂ CUỘN NGANG (Thứ 2 -> Thứ 7) ===
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dòng tiêu đề (Các ngày)
                        Row(
                          children: days.map((day) => _buildCell(
                            day,
                            width: dayWidth,
                            height: headerHeight,
                            bgColor: primaryColor,
                            textColor: Colors.white,
                            isBold: true,
                          )).toList(),
                        ),
                        // Các dòng buổi sáng
                        ...morningData.map((row) => Row(
                          children: row.map((subject) => _buildCell(
                            subject,
                            width: dayWidth,
                            height: cellHeight,
                            bgColor: _getSubjectColor(subject),
                            isBold: subject.isNotEmpty,
                          )).toList(),
                        )),
                        // Các dòng buổi chiều
                        ...afternoonData.map((row) => Row(
                          children: row.map((subject) => _buildCell(
                            subject,
                            width: dayWidth,
                            height: cellHeight,
                            bgColor: _getSubjectColor(subject),
                            isBold: subject.isNotEmpty,
                          )).toList(),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm tạo từng ô (Cell) trong bảng
  Widget _buildCell(String text, {
    required double width,
    required double height,
    Color bgColor = const Color(0xFFF8F9FA),
    Color textColor = const Color(0xFF111111),
    bool isBold = false,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        // Chỉ kẻ viền phải và dưới cho mỗi cell để tránh bị nét đôi (double border)
        border: Border(
          right: BorderSide(color: Colors.grey.shade300, width: 1),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Hàm chọn màu nền tự động dựa theo tên môn học (khớp với hình ảnh của bạn)
  Color _getSubjectColor(String subject) {
    if (subject.isEmpty) return const Color(0xFFF5F6F9);
    if (subject.contains('Vật lí')) return const Color(0xFFBDE0FE);
    if (subject.contains('Tin học')) return const Color(0xFF98F5E1);
    if (subject.contains('Tự học Toán') || subject.contains('Toán')) return const Color(0xFFD6E4F0);
    if (subject.contains('Ngoại ngữ')) return const Color(0xFFFAD2E1);
    if (subject.contains('Lịch Sử')) return const Color(0xFFE2D1F9);
    if (subject.contains('Ngữ văn')) return const Color(0xFFD3F8E2);
    if (subject.contains('GDQP')) return const Color(0xFFECA1F5);
    if (subject.contains('Địa Lí')) return const Color(0xFFFCF4A3);
    if (subject.contains('GDKTPL')) return const Color(0xFF81D4FA);
    if (subject.contains('GDTC')) return const Color(0xFFFFCC80);
    return Colors.white;
  }
}